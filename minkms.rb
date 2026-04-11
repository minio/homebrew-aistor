class Minkms < Formula
  git_tag = "RELEASE.2026-04-09T16-36-52Z"  # MinKMS specific
  
  desc "A cloud-native distributed KMS designed to build zero-trust infrastructures at scale"
  homepage "https://min.io"
  url "https://dl.min.io/enterprise/minkms/release/"
  version git_tag 
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minkms/release/darwin-arm64/archive/minkms.#{version}"
      sha256 "c86b2ba3d0d1d5ebe3b3bb3d5f8aad0fe440c09475f265ab0a0fd5efc8350a34"
    else
      url "https://dl.min.io/aistor/minkms/release/darwin-amd64/archive/minkms.#{version}"
      sha256 "b7defa253880fe22e16a2fed161a6bc29116be73d6011b87950bc28732fbf91d"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minkms/release/linux-arm64/archive/minkms.#{version}"
      sha256 "b5bf696930dcf095f39aa74beb974980474f96b90d85f0de34b6ce1257e61d0e"
    else
      url "https://dl.min.io/aistor/minkms/release/linux-amd64/archive/minkms.#{version}"
      sha256 "f4efd5ce6a83296e8e3659334c12a9e682e091f1793febf160abf95267bca967"
    end
  end

  def install
    bin.install Dir.glob("minkms.*").first => "minkms"
  end

  test do
    system bin/"minkms", "identity" 
  end
end
