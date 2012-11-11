class DocumentsController < ApplicationController
  def index
    @search = Document.search(params[:q])
    @user_agent=UserAgent.parse(request.user_agent)
    
    if params[:tag]
      @documents = Document.tagged_with(params[:tag])
      @page_title="Documents by Tag (" << params[:tag].upcase << ")"
    elsif params[:q]
      @documents=@search.result
      @page_title="Documents by Search Result"
    else
      @documents = Document.recently_added
      @page_title = "Recent Documents"
    end
  end

  def show
    @document = Document.find(params[:id])
    #PdfMailer.mail_pdf(@document, params[:email]).deliver
  end
  
  def email
    @document = Document.find(params[:id])
    #PdfMailer.mail_pdf(@document, params[:email]).deliver   
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(params[:document])
    if @document.save
      redirect_to documents_path, :notice => "Successfully created document."
    else
      render :action => 'new'
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    params[:document][:emails_attributes].values.each do |document|
      PdfMailer.mail_pdf(@document, document[:address],current_user,document[:message]).deliver unless document[:address].empty?
    end if params[:document] and params[:document][:emails_attributes]
    
    ### Delete email attributes before saving ###
    params[:document][:emails_attributes]=[]
      
    if @document.update_attributes(params[:document])
        redirect_to documents_path, :notice  => "Successfully emailed document."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_url, :notice => "Successfully destroyed document."
  end
end
