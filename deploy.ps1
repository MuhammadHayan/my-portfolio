# deploy.ps1
# PowerShell script to build Flutter web app and deploy to GitHub Pages

# === CONFIGURATION ===
$repoName = "my-portfolio"   # your GitHub repo name
$deployBranch = "gh-pages"

# Step 1: Build Flutter web with correct base href
Write-Host "Building Flutter web app with base href '/$repoName/'..." -ForegroundColor Cyan
flutter build web --release --base-href "/$repoName/"

# Step 2: Add 404.html for subpage routing
$webBuildPath = "build/web"
$redirectFile = Join-Path $webBuildPath "404.html"
Write-Host "Creating 404.html for routing..." -ForegroundColor Cyan
@"
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="refresh" content="0; url=./index.html" />
  </head>
</html>
"@ | Out-File -Encoding UTF8 $redirectFile

# Step 3: Deploy to gh-pages branch
Write-Host "Deploying to '$deployBranch' branch..." -ForegroundColor Cyan
cd $webBuildPath

# Initialize git if needed
if (-Not (Test-Path ".git")) {
    git init
    git remote add origin https://github.com/MuhammadHayan/$repoName.git
}

git add .
git commit -m "Deploy Flutter web app to GitHub Pages" -a
git branch -M $deployBranch
git push -f origin $deployBranch

Write-Host "Deployment complete! Visit: https://muhammadhayan.github.io/$repoName/" -ForegroundColor Green
