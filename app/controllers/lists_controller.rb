class ListsController < ApplicationController
  def new
    @list = List.new  #Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
  end

  def create       #1.&2. データを受け取り、新規登録するためのインスタンス作成
    @list = List.new(list_params)       #newメソッドを呼び出され、引数でlist_paramasが呼び出されている。
    if @list.save #3.データをデータベースに保存するためのsaveメソッド実行
      redirect_to list_path(@list.id)   #もしも、バリデーションの結果、対象のカラムにデータが入力されていれば次のページへリダイレクトする。
    else
      render :new                       #もしも、データが入力されていなければ、新規投稿ページを再表示させる。
    end
  end              #ここでcreateアクションの処理は終了！

  def index # 一覧画面用のアクション
    @lists = List.all
  end
  # @～はインスタンス変数。ここで変数を指定しておくことで、viewファイル上でインスタンス変数に格納された情報を表示させることができる。
  # 逆に、ここで指定しておかないと、表示させることができない。
  # .all は、そのモデルがやり取りしているデータベースのテーブルに保存されている、すべてのレコードをまとめて取得するメソッド
  # インスタンス変数は、自由に命名できるが、今回は複数のListレコードが取得できるので複数形とした。

  def show #controllerでdatebaseからlistsテーブルに保存されているデータを１つだけ取得する
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def update #更新機能のためのアクションボタンをつくる。
    list = List.find(params[:id]) # showアクションにリダイレクトするために、引数には必ずidが必要になる。どのデータを詳細画面に表示させるのかを決定する。
    list.update(list_params)
    redirect_to list_path(list.id)
  end

  def destroy
    list = List.find(params[:id])
    list.destroy
    redirect_to '/lists'
  end

  private   #これは一種の境界線。「ここから下は、このcontrollerの中でしか呼び出せません」という意。他のアクション（index,show,edit）を巻き込まないよう、一番下のendのすぐ上に書くこと。
  def list_params #ストロングパラメータ.脆弱性を防ぐセキュリティ
    params.require(:list).permit(:title, :body, :image)
  end
end
    # paramsとは、formから送られてくるデータの容器。
    # 送られてきたデータの中から「:list」を指定し、データを絞り、
    # 保存を許可するカラム（:title,:body）を指定している。
    # これによって、「マスアサインメント脆弱性」を防ぐことができる。

