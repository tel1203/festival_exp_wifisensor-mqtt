#!/usr/bin/ruby2.1

require 'webrick'

# 拡張子「.rb」ファイルをCGIとして実行可能にする。
module WEBrick
  module HTTPServlet
    FileHandler.add_handler("rb", CGIHandler)
  end 
end

# 動作設定
opt = { 
  :DocumentRoot   => '.',
  :Port           => "9999",
  :BindAddress    => nil,
  :ServerType     => WEBrick::Daemon
}
server = WEBrick::HTTPServer.new(opt)

# CGIを実行可能にする
cgi_dir = File.dirname(".")
server.mount("/", WEBrick::HTTPServlet::FileHandler, cgi_dir)

# サーバの終了シグナルを設定する
['INT', 'TERM'].each {|signal| 
  trap(signal) {server.shutdown}
}

# サーバを開始する
server.start

