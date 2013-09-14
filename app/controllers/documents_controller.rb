class DocumentsController < ApplicationController
  before_filter :signed_in_user
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
    @user_agent=UserAgent.parse(request.user_agent)

    @commentable = @document
    @comments = @commentable.comments
    @comment = Comment.new

    #PdfMailer.mail_pdf(@document, params[:email]).deliver
  end

  def email
    @document = Document.find(params[:id])
    PdfMailer.mail_pdf(@document, params[:email]).deliver
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(params[:document])
    if @document.save
      @document.new_update(current_user)
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
        @update=current_user.updates.new
        @update.feed_item=current_user.name << " emailed a document."
        @update.save
        redirect_to documents_path, :notice  => "Successfully emailed document."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @document = Document.find(params[:id])

    @update=current_user.updates.new
    @update.feed_item=current_user.name << " removed a document. | " << @document.description.titleize
    @update.save

    @document.destroy
    redirect_to documents_url, :notice => "Successfully destroyed document."
  end
end
