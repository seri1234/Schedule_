class ScheduleController < ApplicationController
  before_action :logged_in_user, only: [:show,:new, :destroy,:create]
  before_action :correct_user,   only: :destroy                                 #自分のスケジュールか判定
  
  def show
     @day_schedule = DaySchedule.find(params[:id])
     @time_schedule =  @day_schedule.time_schedule

    #グラフ描画用多次元配列の作成
      @chart = []                                                               #グラフ用の配列の宣言
      @time_schedule.each do |num|
        val1  =  num.time_schedule
        val2  =  num.start_time
        val2  =  conversion(val2)                                               #timechartのグラフの時刻表示が９時間ほどずれてしまうので、ずれを無くすために
        val3  =  num.end_time                                                   #applicationhelperのconversionメソッドを自作し、文字列を操作、
        val3  =  conversion(val3)                                               #多次元配列を作り、chartkickでグラフ描画。
        @chart << [val1, val2, val3]
      end
  end

  def new
    @day_schedule = current_user.day_schedule.new
  end
  
  def create
    if  current_user.day_schedule.count < 1                                     #もしログインユーザのDayScheduleのデータの総数数が0なら、スケジュールを作成
      @day_schedule = current_user.day_schedule.build(schedule_params)
      if  @day_schedule.save                                                    #もしsaveが成功したなら
        flash[:success] = "スケジュールの作成に成功しました！"
        redirect_to  new_schedule_time_schedule_url(@day_schedule)              #時間辺りのスケジュール作成ページにリダイレクト
      else                                                                      #もしsaveが失敗したら
        flash.now[:danger] ="入力値が空か、255文字以上です。保存に失敗しました"  #エラーを出して、再描画。
        render 'schedule/new'
      end
    else                                                                        #もしすでにログインユーザの予定が存在すれば、
        @day_schedule = current_user.day_schedule.new                           #render用のダミー@day_schedule
        flash.now[:danger] ="すでにあなたの予定は存在します、ヘッダーリンクの「予定とユーザー情報」ページから、一度予定を削除してからリトライしてください"
        render 'schedule/new'                                                   #エラーを出して、一度削除して作成することを促す。
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
      
    def correct_user
      @day_scheduledayschedule = current_user.day_schedule.find_by(id: params[:id]) #ログインしているユーザーで、アクセスするページのschedule_idを検索
      redirect_to root_url if @day_schedule.nil?                                    #見つからなければルートページにリダイレクト
    end
end



