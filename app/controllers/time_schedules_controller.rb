class TimeSchedulesController < ApplicationController
  
  def new
    @time_schedules =current_user.day_schedule.find(params[:schedule_id]).time_schedule
    @time_schedule = current_user.day_schedule.find(params[:schedule_id]).time_schedule.new
  end
  
  
  def create                                                                    #/posts/posts_id/comentにpostアクセスでcreateアクションを実行。コメントを投稿する
    @time_schedule = current_user.day_schedule.find(params[:schedule_id]).time_schedule.build(time_schedule_params)         #paramsから@commentを作成。その際Postも紐付ける                                      #ログインしている自分自身のidを代入
    if @time_schedule.save!                                                           #もし無事に保存できたら
      respond_to do |format|                                                    #Ajaxリクエストでも応答できるようフォーマットを選択
        format.html { redirect_back(fallback_location: root_path) }             #もしJavaScriptが使えないブラウザなら
        format.js   { render :time_schedule_view}                                     #もしJavaScriptが使えれる環境なら、Ajaxにより、必要部分だけ再描画(comments/comment_view.js.erbを呼び出す)
      end
    else                                                                        #もしsave失敗したら
     render 'posts/show'                                                        #showページを再描画
    end
  end
  
  
  private 
      def time_schedule_params                                                           
        params.require(:time_schedule).permit(:schedule_id,:time_schedule,:time_schedule, :start_time, :end_time)
      end
end

