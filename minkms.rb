class Minkms < Formula
  git_tag = "RELEASE.2025-11-12T19-14-51Z"  # MinKMS specific
  
  desc "A cloud-native distributed KMS designed to build zero-trust infrastructures at scale"
  homepage "https://min.io"
  url "https://dl.min.io/enterprise/minkms/release/"
  version git_tag 
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minkms/release/darwin-arm64/archive/minkms.#{version}"
      sha256 "74f4a63097499208918cba8087b8c93738f0c49b0e35b0a834b7a995493dc1a2"
    else
      url "https://dl.min.io/aistor/minkms/release/darwin-amd64/archive/minkms.#{version}"
      sha256 "847de1beacc07f28703acb838fe8d04c4c19017c19598e5459b1e85f2760841a"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minkms/release/linux-arm64/archive/minkms.#{version}"
      sha256 "df11486fcc78a00d0a68880831a1831f4ceaab40bca71f9179b0b5bd885871ba"
    else
      url "https://dl.min.io/aistor/minkms/release/linux-amd64/archive/minkms.#{version}"
      sha256 "14e1fc42428bc42645a2504f4b50279bbe86a982203b303abdf67e1a1753ff95"
    end
  end

  def install
    bin.install Dir.glob("minkms.*").first => "minkms"
  end

  test do
    system bin/"minkms", "identity" 
  end
end
