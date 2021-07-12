class Kubepfm < Formula
  desc "A simple wrapper to kubectl port-forward for multiple pods."
  homepage "https://github.com/flowerinthenight/kubepfm"
  url "https://github.com/amanzanero/yt/archive/yt-0.0.0.tar.gz"
  sha256 "b6eaf4225e43995183c12dbbc94a62cb73432aaa700d85fda37745e792a57d3b"

  depends_on "go"

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"
    ENV["GOFLAGS"] = "-mod=vendor"
    ENV["PATH"] = "#{ENV["PATH"]}:#{buildpath}/bin"
    (buildpath/"src/github.com/amanzanero/yt").install buildpath.children
    cd "src/github.com/amanzanero/yt" do
      system "go", "build", "-o", bin/"yt", "."
    end
  end

  test do
    assert_match /yt version v0.0.0/, shell_output("#{bin}/yt -h", 0)
  end
end