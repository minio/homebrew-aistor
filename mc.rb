class Mc < Formula
  # mc specific
  git_tag = "RELEASE.2026-06-24T01-47-10Z"

  desc "Enterprise MinIO Client for object storage and filesystems"
  homepage "https://min.io"
  # url "https://github.com/minio/mc"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/darwin-arm64/archive/mc.#{version}"
      sha256 "c86e2ff44e526da33bbdea0487133707dfbb3793df2a6b4898ddc4823a972a48"
    else
      url "https://dl.min.io/aistor/mc/release/darwin-amd64/archive/mc.#{version}"
      sha256 "591e5a1e3dbc8dd8cedaf1325eb63352fe85d2fcb0c55b0726925139163b5886"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/mc/release/linux-arm64/archive/mc.#{version}"
      sha256 "57fac4c8c9608c9f1bfe402f66453ca2fba335d751eba83b45ebe023deb4b29b"
    else
      url "https://dl.min.io/aistor/mc/release/linux-amd64/archive/mc.#{version}"
      sha256 "73c472ab5eb50420bf0887c0325cc2480a047d511e4117941eaec1ea5bed938e"
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
