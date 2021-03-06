require "language/node"

class Heroku < Formula
  desc "Command-line client for the cloud PaaS"
  homepage "https://cli.heroku.com"
  url "https://registry.npmjs.org/heroku/-/heroku-7.0.15.tgz"
  sha256 "844c6acf7f1c88d2906df3e29d9d699a3054abcc41d05e2bd4f04cb7dcf84b2b"
  head "https://github.com/heroku/cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7012f3241e1ce090b1dd537b503d46c20d0c5725ca0d072050998d67c92081c8" => :high_sierra
    sha256 "b01624b4e6a71f9b095263bcd7386fd2b03a763f0262c78118806190972e0ddb" => :sierra
    sha256 "f0ab8149650ecd1a04dbb154fcfcc23c9f4ba33fb0ce13cb881bdafcf35606ec" => :el_capitan
  end

  depends_on "node"

  def install
    inreplace "bin/run", "#!/usr/bin/env node",
                         "#!#{Formula["node"].opt_bin}/node"
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system bin/"heroku", "version"
  end
end
