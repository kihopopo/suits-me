class Public::CommentsController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    comment = item.comments.build(comment_params) #buildを使い、contentとitem_idの二つを同時に代入
    comment.customer_id = current_customer.id
    if comment.save
        flash[:success] = "コメントしました"
        redirect_back(fallback_location: root_path)
    else
        flash[:danger] = "コメントできませんでした"
        redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to item_path(params[:item_id])
  end

 private
 def comment_params
     params.require(:comment).permit(:content, :rate)
 end
end
