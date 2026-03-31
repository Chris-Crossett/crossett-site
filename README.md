# Chris Crossett — Ideas for Major Societal Leaps Forward

A modern, static personal website built with pure HTML, CSS, and JavaScript. Designed to be developed in **VS Code**, updated via **Claude Code**, and deployed on **GitHub Pages** with a custom domain.

## Quick Start (Local Development)

```bash
# Install dependencies (just a local dev server)
npm install

# Start local dev server with hot reload at http://localhost:3000
npm run dev
```

## Site Structure

```
crossett-site/
├── index.html                 # Homepage
├── federal-reform.html        # Federal Reform Overview
├── federal-taxes.html         # Individual Federal Income Tax
├── national-sales-tax.html    # National Sales Tax
├── federal-spending.html      # Federal Government Spending
├── non-financial-changes.html # Non-Financial Reforms
├── privatization.html         # Privatization
├── state-govt.html            # State Government
├── county-govt.html           # County Government
├── local-govt.html            # Local Government
├── mortgages.html             # Mortgage Reform
├── real-estate.html           # Real Estate Reform
├── daily-finance.html         # Daily Finance
├── about.html                 # About Me
├── contact.html               # Contact
├── css/
│   └── style.css              # Complete stylesheet
├── js/
│   └── main.js                # Navigation & animations
├── .vscode/
│   ├── settings.json          # Editor settings
│   └── extensions.json        # Recommended extensions
├── CNAME                      # GitHub Pages custom domain
├── .nojekyll                  # Bypass Jekyll processing
├── .gitignore
├── package.json
└── README.md
```

## Workflow: Edit with Claude Code → Push to GitHub → Live on GitHub Pages

### Day-to-day updates

```bash
# Open the project in VS Code
code ~/crossett-site

# Or use Claude Code directly from the terminal
cd ~/crossett-site
claude

# After making changes, push to GitHub:
git add .
git commit -m "Update: description of changes"
git push
```

GitHub Pages will automatically redeploy within ~60 seconds of each push.

### Example Claude Code prompts

- "Add a new page about healthcare reform to the site"
- "Update the National Sales Tax page with new 2026 data"
- "Add a dark mode toggle to the navigation"
- "Improve the mobile layout on the mortgages page"

Claude Code will see the full project structure and can edit any file directly.

---

## First-Time Setup

### 1. Create the GitHub Repository

```bash
cd ~/crossett-site

# Initialize git
git init
git add .
git commit -m "Initial commit: modern static site for chris.crossett.net"

# Create the repo on GitHub (pick ONE method):

# Method A: GitHub CLI (if you have 'gh' installed)
gh repo create Chris-Crossett/crossett-site --public --source=. --push

# Method B: Manual
#   1. Go to github.com → New Repository → name it "crossett-site"
#   2. Do NOT initialize with README (we already have one)
#   3. Then run:
git remote add origin https://github.com/Chris-Crossett/crossett-site.git
git branch -M main
git push -u origin main
```

### 2. Enable GitHub Pages

1. Go to your repo on GitHub → **Settings** → **Pages**
2. Under **Source**, select **Deploy from a branch**
3. Choose **main** branch, **/ (root)** folder
4. Click **Save**
5. GitHub will show you the URL (initially `https://chris-crossett.github.io/crossett-site/`)

### 3. Configure DNS for Custom Domain

At your domain registrar (wherever you manage `crossett.net`), add:

```
Type:   CNAME
Name:   chris
Value:  Chris-Crossett.github.io
TTL:    3600
```

> **Note:** The `CNAME` file in this repo tells GitHub Pages to serve the site at `chris.crossett.net`. Make sure the value matches your GitHub username exactly (case-insensitive).

### 4. Enforce HTTPS

After DNS propagates (up to 24 hours, usually much faster):

1. Go to **Settings** → **Pages**
2. Your custom domain should show as verified
3. Check **Enforce HTTPS**

### 5. Verify

Visit `https://chris.crossett.net` — your new site should be live.

---

## Technology

- **Pure HTML/CSS/JS** — no build step, no bundler, no framework
- **Google Fonts**: Cormorant Garamond (display), DM Sans (body), JetBrains Mono (accents)
- **Responsive**: Mobile-first with breakpoints at 600px and 900px
- **Animations**: CSS keyframes + Intersection Observer scroll triggers
- **Dev Server**: `live-server` for local development with hot reload
- **Zero framework dependencies**: Works directly in any browser
