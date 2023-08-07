describe '四則演算' do
  context '足し算' do
    it '1 + 1 は 2 になる' do
      expect(1 + 1).to eq 2
    end
  end
  context '足し算' do
    it '1 + 1 は 2 になる' do
      expect(1 + 1).to eq 3
    end
  end
end


describe '投稿のテスト' do
  let!(:post) { create(:post,title:'hoge',caption:'caption') }
  
  describe 'トップ画面(root_path)のテスト' do
    before do 
      visit root_path
    end
    context '表示の確認' do
      it 'トップ画面(root_path)に一覧ページへのリンクが表示されているか' do
        expect(page).to have_link "", href: posts_path
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end
  
end