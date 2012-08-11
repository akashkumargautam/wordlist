class WordController < ApplicationController
   
  def index
    end
  
  #To see the list of words available in our database
  def list
    @words=Word.find(:all)
  end
  
  def enterwords    
  end
   
#to calculate the hamming distance between 'u' and 'v'   
  def hamm(u,v)
    h=0
    k=u.length
    for i in (0..k-1) do
      if (u[i]!=v[i])
        then h+=1
      end
    end
    return h
  end
  
  #To find all the set of vertices (or words) which are equal in length with inputs.
  def gvs(s,aow)
    gver=[]
    aow.each do |item|
      if (item.length==s.length) then gver=gver<<item
      end
    end
    return gver
  end
  
  #To find the neighbours of vertex u.
  def nebr(u)
    @wa=[]
    @w=Word.find(:all)
    @w.each do |item|
      @wa=@wa<<item.wordvalue
    end
    nb=[]
    gvs(u,@wa).each do |elem|
      if (hamm(elem,u)==1)
        then nb=nb<<elem
      end
    end
    return nb
  end
  
  #To check whether both u and v lies in our database.
  def check(u,v)
	  k=0
	  p=0
	  @ww=Word.find(:all)
	  @ww.each do |item|
		  if (u==item.wordvalue)
then k=1
end
if (v==item.wordvalue)
	then p=1
end
end
return (p+k)
  end
  
     
   #...the main function to calculate wordpath...  
  def wordpath
    @a = params[:word ][:first] #@a stores the first word(input by user)
    @b = params[:word][:second] #@b stores the second word(input by user)
    @fpath=[] # Stores the final word path
    @cpath=[] #Stores the temporary word path
    
    #Check 1) are the two words(input) of equal length?
    #        2) is first or second word empty?
    #         3)do both inputs lie in database?
    if (@a.length!=@b.length || @a.length==0 || @b.length==0 || check(@a,@b)!=2)
      then 
      flash[:notice] = 'Words are not of equal length.'
      redirect_to :action => 'enterwords'
    else
    @wordsarray=[] #An array of all words
    @words=Word.find(:all)
    @words.each do |item|
      @wordsarray=@wordsarray<<item.wordvalue
    end
    n=hamm(@a,@b)
    @spath=[@a]
    u=@a
    while (n>=0)
    temp={}
    for elem in nebr(u).sort do
      temp[elem]=hamm(@b,elem)
    end
    i=temp.values.min
    for k in temp.keys do
      if temp[k]==i
        then
        u=k
        n=n-1
        @spath=@spath<<u
        break
      end
    end
  end
  if @spath.length>(@a.length+1)
    then @cpath=@spath[0..@spath.length-2]
    else
      @cpath=@spath
    end
    @cpath.each do |t|
	    @fpath=@fpath<<t
	    if t==@b
	 then
	 break
 end
 end
 if @fpath[@fpath.length-1]!=@b
	 then @fpath=[]
	 end
  end  
  end
    
    
    
 end
  
        