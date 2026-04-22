cask "blackmagic-ai" do
  version "0.4.64"

  on_arm do
    sha256 "6958a34b215b52f15a92d1c939760f81539d1a65499ede1960f368cd19605ae2"
    url "https://pub-d259d1d2737843cb8bcb2b1ff98fc9c6.r2.dev/blackmagic-desktop/BlackMagic%20AI-#{version}-arm64.dmg",
        verified: "pub-d259d1d2737843cb8bcb2b1ff98fc9c6.r2.dev/blackmagic-desktop/"
  end

  on_intel do
    sha256 "1cd8b3fbcf60f1630b3d3eaed25db880ae0c764da3e14b0de63b5894d8955d1f"
    url "https://pub-d259d1d2737843cb8bcb2b1ff98fc9c6.r2.dev/blackmagic-desktop/BlackMagic%20AI-#{version}.dmg",
        verified: "pub-d259d1d2737843cb8bcb2b1ff98fc9c6.r2.dev/blackmagic-desktop/"
  end

  name "BlackMagic AI"
  desc "Agent-first AI desktop app"
  homepage "https://github.com/furudo-erika/blackmagic-desktop"

  app "BlackMagic AI.app"

  # Belt-and-suspenders: strip quarantine + any lingering xattrs on the
  # installed app. Our build re-signs ad-hoc in afterPack, which resolves
  # the "app is damaged" Gatekeeper error caused by Electron's default
  # linker-signed stub having a mismatched identifier.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/BlackMagic AI.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/BlackMagic AI",
    "~/Library/Logs/BlackMagic AI",
    "~/Library/Preferences/run.blackmagic.desktop.plist",
    "~/Library/Saved Application State/run.blackmagic.desktop.savedState",
  ]
end
