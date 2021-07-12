class Yt < Formula
  desc "A simple wrapper to kubectl port-forward for multiple pods."
  homepage "https://github.com/amanzanero/yt"
  url "https://github.com/amanzanero/yt/archive/refs/tags/0.0.0.tar.gz"
  sha256 "d6b5f235212aa0ea1daa6e51dc6605677f1e4585a0124c2b925d18a3fcd6114a"

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