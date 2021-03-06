class PostsController < ApplicationController
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
  
  
  # LOGIN /login
  def login
    if(session[:valid] && session[:valid] == true)
      redirect_to :action => "home"
    else    
      session[:valid] = false
      end
  end
  
  # LOGIN ACTION /login_action
  def login_action
    login = params[:login]
    pass = params[:pass]
      
    if(login == "ocho" && pass == "cinco")
      redirect_to :action => "home"
      session[:valid] = true     
    else
      redirect_to :action => "login"
      session[:valid] = false
    end
  end
  
  
  # HOME /home
  def home
    puts "home!"
    if(session[:valid] != true )
      puts "invalid!"
      redirect_to :action => "login"
    end
    
    @posts = Post.find( :all, :order => "id desc" )      
  end
  
  # Add Artist /add_artist
  def add_artist
    poster = params[:poster]
    artist = params[:artist]
    album = params[:album]
    link = params[:link]
    comment = params[:comment]
    
    if link.index("http://") != 0
      link = "http://" + link      
    end

    post = Post.new
    post.poster = poster
    post.artist = artist
    post.album = album
    post.link = link
    post.comment = comment
    post.down = false
    post.save
    
    redirect_to   :action => "home"
  end
  
  # Mark Album as Inactive
  def mark_down
    post = Post.find(params[:id])
    post.down = true
    post.save
    
    redirect_to :action => "home"
  end

  # Mark Album as Active
  def mark_up
    post = Post.find(params[:id])
    post.down = false
    post.save
    
    redirect_to :action => "home"
  end
    
end
