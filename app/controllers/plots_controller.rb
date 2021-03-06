class PlotsController < ApplicationController
  layout nil
  respond_to :html, :json, :xml

  def destroy
    
  end
  def create
    
  end
  def new
   
   time=2.hours.ago
   start_time=Time.parse("#{time.year}-#{time.month}-#{time.day} #{time.hour}:00")
   
   data=DataChunk.where(:start_at => start_time).first
   
   
    unless data
      @plot_data=Hash.new()
      @plot_data["status"]="error"
      return
    end

    @plot_data=Hash.new()
    @plot_data["date"]=data.start_at.in_time_zone.strftime("%D")
    @plot_data["phase"]='1'
    @plot_data["image_url"]=data.basename+'.prep1.png'
    
  end
  def index
    
    
    start_time=Time.parse("#{params[:year]}-#{params[:month]}-#{params[:date]} #{params[:hour]}:00")
   
    data=DataChunk.where(:start_at => start_time).first
   
    unless data
      @plot_data=Hash.new()
      @plot_data["status"]="error"
      return
    end

    image_ext='error'
    case params[:phase]
    when '1'
      image_ext='.prep1.png'
    when '2'
      image_ext='.prep2.png'
    when '3'
      image_ext='.prep3.png'
    else
      image_ext='illegal phase'
    end
    
    @plot_data=Hash.new()
    @plot_data["date"]=data.start_at.in_time_zone.strftime("%D")
    @plot_data["phase"]=params[:phase]
    @plot_data["image_url"]=data.basename+image_ext
    
  end

  def live
    system('/home/nilm/scripts/prepper-live.py /home/nilm/data/current')
  end

end
