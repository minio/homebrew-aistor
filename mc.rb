class Mc < Formula
  # mc specific
  git_tag = "RELEASE.2026-07-24T01-15-12Z"

  desc "Enterprise MinIO Client for object storage and filesystems"
  homepage "https://min.io"
  # url "https://github.com/minio/mc"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/darwin-arm64/archive/mc.#{version}"
      sha256 "e5f77503d41b408e6e7c110c1a8018b7d863d7d418dc10f26bbbfd78384a7611"
    else
      url "https://dl.min.io/aistor/mc/release/darwin-amd64/archive/mc.#{version}"
      sha256 "8d9c8ad44ad9ae9d0836bd2a3da97f6ec3e208f0ce3bde0d1be3cf6c0f3d2ddf"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/linux-arm64/archive/mc.#{version}"
      sha256 "6cbe5bfbcbd1d7637ab56e6b814df3ed29e647fcf4391a65d39c3bdfa6c5620c"
    else
      url "https://dl.min.io/aistor/mc/release/linux-amd64/archive/mc.#{version}"
      sha256 "e3d3b53ca6d276c6f9056e99b7db59159be3befb5871bf088bb804955752d6ca"
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
