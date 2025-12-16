# BabyGuardian iOS App Setup Script for Windows
# Note: iOS development requires macOS and Xcode

Write-Host "🚀 BabyGuardian iOS App Setup" -ForegroundColor Cyan
Write-Host ""

Write-Host "⚠️  IMPORTANT: iOS development requires macOS and Xcode" -ForegroundColor Yellow
Write-Host ""
Write-Host "This project is configured for iOS development and cannot be built on Windows." -ForegroundColor Yellow
Write-Host ""
Write-Host "To build this app, you need:" -ForegroundColor White
Write-Host "  1. A Mac computer with macOS" -ForegroundColor White
Write-Host "  2. Xcode 14.0 or later (from Mac App Store)" -ForegroundColor White
Write-Host "  3. XcodeGen (install via: brew install xcodegen)" -ForegroundColor White
Write-Host ""
Write-Host "Setup steps on macOS:" -ForegroundColor Cyan
Write-Host "  1. Install XcodeGen: brew install xcodegen" -ForegroundColor White
Write-Host "  2. Generate project: xcodegen generate" -ForegroundColor White
Write-Host "  3. Open in Xcode: open BabyGuardian.xcodeproj" -ForegroundColor White
Write-Host "  4. Resolve packages: File > Packages > Resolve Package Versions" -ForegroundColor White
Write-Host "  5. Select simulator and press Cmd + R to run" -ForegroundColor White
Write-Host ""
Write-Host "Alternatively, use the setup.sh script on macOS:" -ForegroundColor Cyan
Write-Host "  chmod +x setup.sh && ./setup.sh" -ForegroundColor White
Write-Host ""

# Check if we can at least validate the project structure
Write-Host "📋 Validating project structure..." -ForegroundColor Cyan

$requiredDirs = @("App", "Models", "Services", "Views", "DesignSystem", "Resources")
$missingDirs = @()

foreach ($dir in $requiredDirs) {
    if (Test-Path $dir) {
        Write-Host "  ✅ $dir/" -ForegroundColor Green
    } else {
        Write-Host "  ❌ $dir/ (missing)" -ForegroundColor Red
        $missingDirs += $dir
    }
}

if ($missingDirs.Count -eq 0) {
    Write-Host ""
    Write-Host "✅ Project structure is valid!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "❌ Missing directories: $($missingDirs -join ', ')" -ForegroundColor Red
}

Write-Host ""
Write-Host "📄 Project configuration:" -ForegroundColor Cyan
if (Test-Path "project.yml") {
    Write-Host "  ✅ project.yml found" -ForegroundColor Green
} else {
    Write-Host "  ❌ project.yml missing" -ForegroundColor Red
}

Write-Host ""
Write-Host "For detailed instructions, see BUILD_INSTRUCTIONS.md" -ForegroundColor Cyan
Write-Host ""

