class ScheduleController < ApplicationController

  def new
    @day_schedule = current_user.day_schedule.new
  end
  

  def create
    
    if  current_user.day_schedule.count < 1
      @day_schedule = current_user.day_schedule.build(schedule_params)
      if  @day_schedule.save!   
        flash[:success] = "schedule updated"
        redirect_to  new_schedule_time_schedule_url(@day_schedule)
      else 
        @day_schedule = current_user.day_schedule.new
        flash.now[:danger] ="失敗です"
        render 'schedule/new'
      end
    else 
        @day_schedule = current_user.day_schedule.new
        flash.now[:danger] ="すでに存在します、削除してください"
        render 'schedule/new'
    end
  end

  def show
     @day_schedule =  current_user.day_schedule.find(params[:id])
     @time_shcedule =  @day_schedule.time_schedule
  end
  

  def destroy
  end
  
    private 

      def schedule_params
        params.require(:day_schedule).permit(:id,:day_schedule)
      end

end