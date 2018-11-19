# frozen_string_literal: true

class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_document, only: %i[show edit update destroy email_doc]

  # GET /documents
  # GET /documents.json
  def index
    @documents = current_user.documents
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    data = @document.decrypt_file

    file_hash = { filename: @document.filename, type: @document.content_type }
    file_hash[:disposition] = 'inline' if params[:type] == 'view'

    send_data(data, file_hash)
  end

  def email_doc
    ApplicationMailer.send_document(@document, params[:email]).deliver
    flash[:success] = 'Email has been sent successfully.'

    redirect_to documents_path
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit; end

  # POST /documents
  # POST /documents.json
  def create
    @document = current_user.documents.new(document_params)
    @document.uploaded_file = params[:document][:file]
    respond_to do |format|
      if @document.save
        format.html { redirect_to documents_path, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = current_user.documents.where(id: params[:id]).first
    unless @document.present?
      flash[:error] = 'This document does not belongs to you.'
      return redirect_to documents_path
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def document_params
    params.require(:document).permit(:year, :file_format, :form_name, :company_name)
  end
end
