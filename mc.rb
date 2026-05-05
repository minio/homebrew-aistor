class Mc < Formula
  # mc specific
  git_tag = "RELEASE.2026-04-21T04-26-49Z"

  desc "Enterprise MinIO Client for object storage and filesystems"
  homepage "https://min.io"
  # url "https://github.com/minio/mc"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/darwin-arm64/archive/mc.#{version}"
      sha256 "df4e0ee451b9e075d1adedaaaee3d82c9515e50c704f743838eabfed28704356"
    else
      url "https://dl.min.io/aistor/mc/release/darwin-amd64/archive/mc.#{version}"
      sha256 "a41c16c7608d422718986724b9f26a2e9bdc7b867e61a030e0582d5aa487b551"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/linux-arm64/archive/mc.#{version}"
      sha256 "8a1b30a16cfeb8576b81f96ba0a822f23f75b1d0c4f8f978fbaf73068547252c"
    else
      url "https://dl.min.io/aistor/mc/release/linux-amd64/archive/mc.#{version}"
      sha256 "69168d9c26a87921ec95971f2efe33e37c712acc167cd73af7e2f3bd9cd00d17"
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
