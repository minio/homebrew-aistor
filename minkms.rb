class Minkms < Formula
  git_tag = "RELEASE.2025-08-18T19-50-54Z"  # MinKMS specific
  
  desc "A cloud-native distributed KMS designed to build zero-trust infrastructures at scale"
  homepage "https://min.io"
  url "https://dl.min.io/enterprise/minkms/release/"
  version git_tag 
  revision 1

  if OS.mac?
      url "https://dl.min.io/aistor/minkms/release/darwin-arm64/archive/minkms.#{version}"
      sha256 "7830f9c8c8559f7067d2b97963d20c60a62f27fd587159d9cec9b5da9fbe23ff"
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minkms/release/linux-arm64/archive/minkms.#{version}"
      sha256 "6ef934b2abc7ab58316374aae9d3c685d9189c7e15dcd3a1b707c439b4d6d4f3"
    else
      url "https://dl.min.io/aistor/minkms/release/linux-amd64/archive/minkms.#{version}"
      sha256 "fe1166770fb28ec690ae4c176173cb743fd211755b470ccb244650b891e96338"
    end
  end

  def install
    bin.install Dir.glob("minkms.*").first => "minkms"
  end

  test do
    system bin/"minkms", "identity" 
  end
end
