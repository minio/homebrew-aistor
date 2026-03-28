class Mc < Formula
  # mc specific
  git_tag = "RELEASE.2026-03-27T15-57-12Z"

  desc "Enterprise MinIO Client for object storage and filesystems"
  homepage "https://min.io"
  # url "https://github.com/minio/mc"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/darwin-arm64/archive/mc.#{version}"
      sha256 "8e14697d48342bb3a182ba54982eed1f4ab47753200b02e40402c18b4b2f61ef"
    else
      url "https://dl.min.io/aistor/mc/release/darwin-amd64/archive/mc.#{version}"
      sha256 "004a9ab003bb4546d471ee3ce44a9e6e96b941b684d6e8333544436882b30fc3"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/linux-arm64/archive/mc.#{version}"
      sha256 "1bb13d07c805dd6c119470947edba372afbff38f4138cc6eda36b10a02149773"
    else
      url "https://dl.min.io/aistor/mc/release/linux-amd64/archive/mc.#{version}"
      sha256 "26756df49bb06815580f81bb3fae632920883e8ec5dc34efdb7ec7e1263a7ee4"
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
