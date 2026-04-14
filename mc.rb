class Mc < Formula
  # mc specific
  git_tag = "RELEASE.2026-04-13T21-15-24Z"

  desc "Enterprise MinIO Client for object storage and filesystems"
  homepage "https://min.io"
  # url "https://github.com/minio/mc"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/darwin-arm64/archive/mc.#{version}"
      sha256 "f2d7cbe68b632c857b20bd47716e4ee2c436ff1bb721cc3769c77432a26c5d6d"
    else
      url "https://dl.min.io/aistor/mc/release/darwin-amd64/archive/mc.#{version}"
      sha256 "c9f00c89e59c09b6e7a5f677181722b9967f1fe63ee265a279e0234f89ab6738"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/linux-arm64/archive/mc.#{version}"
      sha256 "01a0e1585c2a8465ce8fe26443adce756c7ad217568b078e3fab4ea43f544737"
    else
      url "https://dl.min.io/aistor/mc/release/linux-amd64/archive/mc.#{version}"
      sha256 "672b8a17e5707f9387a42d1e647d1d2cb78597f847aa56642b541d81ee036be5"
    end
  end

  conflicts_with "midnight-commander", :because => "Both install `mc`"

  def install
    bin.install Dir.glob("mc.*").first => "mc"
  end

  test do
    system bin/"mc", "mb", testpath/"test"
  end
end
