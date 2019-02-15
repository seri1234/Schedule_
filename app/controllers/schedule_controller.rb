class ScheduleController < ApplicationController

  def new
    @day_schedule = current_user.day_schedule.new
  end
  

  def create
    
    if  current_user.day_schedule.count < 1                                     #もしログインユーザの.day_scheduleデータの総数数が0なら、スケジュールを作成
      @day_schedule = current_user.day_schedule.build(schedule_params)                                                      #スケジュールを作成、削除するたびにday_schedule_idが増えてしまうので、1に指定する。
      if  @day_schedule.save                                                    #もしsaveが成功したなら
        flash[:success] = "スケジュールの作成に成功しました！"
        redirect_to  new_schedule_time_schedule_url(@day_schedule)              #時間辺りのスケジュール作成ページにリダイレクト
      else                                                                      #もしsaveが失敗したら
        flash.now[:danger] ="入力値が空か、255文字以上です。保存に失敗しました"              #エラーを出して、再描画。
        render 'schedule/new'
      end
    else                                                                        #もしすでにログインユーザの予定がもう存在すれば、
        @day_schedule = current_user.day_schedule.new                           #render用のダミー@day_schedule
        flash.now[:danger] ="すでにあなたの予定は存在します、ヘッダーリンクのマイページから、スケジュールページに移動し、削除してからリトライしてください"
        render 'schedule/new'                                                   #エラーを出して、リトライを促す。
    end
  end

  def show
     @day_schedule = DaySchedule.find(params[:id])
     @time_shcedule =  @day_schedule.time_schedule

    #グラフ描画用多次元配列の作成
      @chart = []                                                               #グラフ用の配列の宣言
      
      @time_shcedule.each do |num|
        val1  =  num.time_schedule
        val2  =  num.start_time
        val2  =  conversion(val2)                                               #timechartのグラフの時刻表示が９時間ほどずれてしまうので、ずれを無くすために
        val3  =  num.end_time                                                   #applicationhelperのconversionメソッドを自作し、文字列を操作、
        val3  =  conversion(val3)                                               #多次元配列を作り、chartkickでグラフ描画。
        @chart << [val1, val2, val3]                                            
      end
    
    
  end
  

  def destroy
    @day_schedule = current_user.day_schedule.find(params[:id])
    @day_schedule.destroy
    flash[:success] = "スケジュールを削除しました"
    redirect_to root_url 
  end
  
    private 

      def schedule_params
        params.require(:day_schedule).permit(:id,:day_schedule)
      end

end



