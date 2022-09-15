class Wrk2 < Formula
  desc "Constant throughput, correct latency recording variant of wrk with ARM support"
  homepage "https://github.com/outsinre/wrk2"
  url "https://github.com/outsinre/wrk2/archive/refs/tags/1.0.1.tar.gz"
  sha256 "49d7cd01e1de67b12b98e2c3c9453905af035bab7a979bb43c42a0a2ee84f41d"
  license "Apache-2.0"
  head "https://github.com/outsinre/wrk2.git", branch: "master"

  depends_on "openssl@1.1"

  # conflicts_with "wrk-trello", because: "both install `wrk` binaries"

  def install
    ENV.deparallelize
    # Per https://luajit.org/install.html: If MACOSX_DEPLOYMENT_TARGET
    # is not set then it's forced to 10.4, which breaks compile on Mojave.
    ENV["MACOSX_DEPLOYMENT_TARGET"] = MacOS.version
    system "make"
    mv "wrk", "wrk2"
    bin.install "wrk2"
  end

  test do
    system "#{bin}/wrks", "-r", "5", "-c", "1", "-t", "1", "-d", "1", "https://example.com/"
  end
end
