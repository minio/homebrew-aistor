class Mc < Formula
  # mc specific
  git_tag = "RELEASE.2026-03-12T19-18-47Z"

  desc "Enterprise MinIO Client for object storage and filesystems"
  homepage "https://min.io"
  # url "https://github.com/minio/mc"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/darwin-arm64/archive/mc.#{version}"
      sha256 "3111056f3a9b4fd75a307e3766b87b872f427f816ed5a4403954875baff5a0f4"
    else
      url "https://dl.min.io/aistor/mc/release/darwin-amd64/archive/mc.#{version}"
      sha256 "fbafe500f31deae085d58a0e05b44769ae3c9d0255611aba325574f4ae71b993"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/linux-arm64/archive/mc.#{version}"
      sha256 "96db676d6cb626be64184e73b2de997917e18dabdeffc03f794d16c49f09a215"
    else
      url "https://dl.min.io/aistor/mc/release/linux-amd64/archive/mc.#{version}"
      sha256 "ee0978d810c6e438e0b2a30646634ddd4321f74e507cdfc4e7d0251cf1cdba51"
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
