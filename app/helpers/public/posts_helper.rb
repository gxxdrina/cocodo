module Public::PostsHelper
    
  ## リンク付きのハッシュタグが入ったキャプションを作成
  def render_with_hashtags(caption)
    # ハッシュタグ名が末尾に入ったURLを作成し、ハッシュタグクリック時のリンク先として設定
    caption.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) { |word| link_to word, "/post/hashtag/#{word.delete("#" "＃")}" }.html_safe
  end
end
