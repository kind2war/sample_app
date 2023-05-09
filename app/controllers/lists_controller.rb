class ListsController < ApplicationController
  def new
    # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @list = List.new
  end

  def create
    #1.&2. データを受け取り、新規登録するためのインスタンス作成
    list = List.new(list_params)
      #newメソッドを呼び出され、引数でlist_paramasが呼び出されている。
      #listに「@」が付かないのは、「ローカル変数」を利用して、createアクション処理をするためだから。
      #復習:インスタンス変数とローカル変数の違い
    #3.データをデータベースに保存するためのsaveメソッド実行
    list.save
    #4.トップ画面へリダイレクト
    redirect_to '/top'
  end # ここでcreateアクションの処理は終了！

  def index # 一覧画面用のアクション
    @lists = List.all
  end
  # @～はインスタンス変数。ここで変数を指定しておくことで、viewファイル上でインスタンス変数に格納された情報を表示させることができる。
  # 逆に、ここで指定しておかないと、表示させることができない。
  # .all は、そのモデルがやり取りしているデータベースのテーブルに保存されている、すべてのレコードをまとめて取得するメソッド
  # インスタンス変数は、自由に命名できるが、今回は複数のListレコードが取得できるので複数形とした。

  def show
  end

  def edit
  end

  private   #これは一種の境界線。「ここから下は、このcontrollerの中でしか呼び出せません」という意。
           #他のアクション（index,show,edit）を巻き込まないよう、一番下のendのすぐ上に書くこと。
  # ストロングパラメータ
  def list_params # 脆弱性を防ぐセキュリティ
    params.require(:list).permit(:title, :body)
    # paramsとは、formから送られてくるデータの容器。
    # 送られてきたデータの中から「:list」を指定し、データを絞り、
    # 保存を許可するカラム（:title,:body）を指定している。
    # これによって、「マスアサインメント脆弱性」を防ぐことができる。
  end
end
