class TimeSchedulesController < ApplicationController
  
  def new
    @time_schedules = current_user.day_schedule.find(params[:schedule_id]).time_schedule
    @time_schedule = current_user.day_schedule.find(params[:schedule_id]).time_schedule.build

   #グラフ描画用多次元配列の作成      

      @chart = []                                                               #グラフ用の配列の宣言
      @time_schedules.each do |num|
        val1  =  num.time_schedule
        val2  =  num.start_time
        val2  =  conversion(val2)                                               #timechartのグラフの時刻表示が９時間ほどずれてしまうので、ずれを無くすために
        val3  =  num.end_time                                                   #applicationhelperのconversionメソッドを自作し、文字列を操作、
        val3  =  conversion(val3)                                               #多次元配列を作り、chartkickでグラフ描画。
        @chart << [val1, val2, val3]                                            
      end
  end
  
  
  def create                                                                    
    @time_schedule = current_user.day_schedule.find(params[:schedule_id]).time_schedule.build(time_schedule_params)
    if @time_schedule.save                                                          
      respond_to do |format|                                                    
        format.html { redirect_back(fallback_location: root_path) } 
        format.js   { render :time_schedule_view}
      end
    else
      flash.now[:danger] = "「時間辺りの予定名」欄が空か256文字以上です。「予定を追加する」で再度追加するか、スケジュールを削除して、もう一度作り直してください。"
      @time_schedules = []
      @user = current_user
     render 'users/show'
    end
  end
  
  
    private 
  
      def time_schedule_params                                                           
        params.require(:time_schedule).permit(:schedule_id,:time_schedule,:time_schedule, :start_time, :end_time)
      end
end

