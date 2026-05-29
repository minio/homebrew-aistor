class Minkms < Formula
  git_tag = "RELEASE.2026-05-20T12-12-28Z"  # MinKMS specific
  
  desc "A cloud-native distributed KMS designed to build zero-trust infrastructures at scale"
  homepage "https://min.io"
  url "https://dl.min.io/enterprise/minkms/release/"
  version git_tag 
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minkms/release/darwin-arm64/archive/minkms.#{version}"
      sha256 "99c692033cab8d67d994ef70cdd386c744178f7077a86b856a99ac37176ef342"
    else
      url "https://dl.min.io/aistor/minkms/release/darwin-amd64/archive/minkms.#{version}"
      sha256 "9ddb650d33aa2d380d440aa160d5d5cfce5e5c5a22251b30eaec83df16a60a56"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minkms/release/linux-arm64/archive/minkms.#{version}"
      sha256 "cf2bd8b1d4bb316ad90d87a70414277428a80b05a540f2d1bfeff7f2e1078af9"
    else
      url "https://dl.min.io/aistor/minkms/release/linux-amd64/archive/minkms.#{version}"
      sha256 "4bd36e39341333a6bf00efc4618a5bfcd99bf15e46cb3d5eed4e0a1ec16bad58"
    end
  end

  def install
    bin.install Dir.glob("minkms.*").first => "minkms"
  end

  test do
    system bin/"minkms", "identity" 
  end
end
