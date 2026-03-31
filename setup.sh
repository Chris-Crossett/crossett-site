#!/bin/bash
# Setup script for crossett-site
# Run from inside your ~/crossett-site directory

echo "Setting up crossett-site project..."

# Create directories
mkdir -p css js .vscode

# Create .gitignore
cat > .gitignore << 'GITIGNORE'
node_modules/
.DS_Store
Thumbs.db
*.log
.env
GITIGNORE

# Create .nojekyll
touch .nojekyll

# Create CNAME
echo "chris.crossett.net" > CNAME

# Create .vscode/settings.json
cat > .vscode/settings.json << 'VSCODE_SETTINGS'
{
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "editor.tabSize": 2,
  "editor.wordWrap": "on",
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "liveServer.settings.port": 3000,
  "liveServer.settings.donotShowInfoMsg": true
}
VSCODE_SETTINGS

# Create .vscode/extensions.json
cat > .vscode/extensions.json << 'VSCODE_EXT'
{
  "recommendations": [
    "ritwickdey.liveserver",
    "esbenp.prettier-vscode",
    "formulahendry.auto-rename-tag",
    "ecmel.vscode-html-css"
  ]
}
VSCODE_EXT

# ============================================================
# CSS
# ============================================================
cat > css/style.css << 'CSSEOF'
@import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,600;0,700;1,400&family=DM+Sans:ital,wght@0,400;0,500;0,600;0,700;1,400&family=JetBrains+Mono:wght@400;500&display=swap');
:root {
  --color-ink: #0d1117; --color-ink-soft: #30363d; --color-ink-muted: #6e7681;
  --color-surface: #faf9f7; --color-surface-alt: #f0eeeb; --color-surface-card: #ffffff;
  --color-accent: #1a5276; --color-accent-deep: #0e3348; --color-accent-light: #d4e6f1;
  --color-gold: #b8860b; --color-gold-soft: #f5e6c8;
  --color-border: #d8d4cf; --color-border-light: #e8e5e0; --color-white: #ffffff;
  --font-display: 'Cormorant Garamond', Georgia, serif;
  --font-body: 'DM Sans', -apple-system, sans-serif;
  --font-mono: 'JetBrains Mono', monospace;
  --space-xs: 0.25rem; --space-sm: 0.5rem; --space-md: 1rem; --space-lg: 1.5rem;
  --space-xl: 2.5rem; --space-2xl: 4rem; --space-3xl: 6rem;
  --radius-sm: 4px; --radius-md: 8px; --radius-lg: 16px;
  --shadow-sm: 0 1px 3px rgba(0,0,0,0.06); --shadow-md: 0 4px 16px rgba(0,0,0,0.08);
  --shadow-lg: 0 8px 32px rgba(0,0,0,0.1);
  --max-width: 1200px; --content-width: 760px;
  --transition: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { scroll-behavior: smooth; -webkit-font-smoothing: antialiased; }
body { font-family: var(--font-body); font-size: 16px; line-height: 1.7; color: var(--color-ink); background: var(--color-surface); overflow-x: hidden; }
img { max-width: 100%; height: auto; display: block; }
a { color: var(--color-accent); text-decoration: none; transition: color var(--transition); }
a:hover { color: var(--color-gold); }
.container { max-width: var(--max-width); margin: 0 auto; padding: 0 var(--space-lg); }
.nav { position: fixed; top: 0; left: 0; right: 0; z-index: 1000; background: rgba(250,249,247,0.92); backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px); border-bottom: 1px solid var(--color-border-light); transition: all var(--transition); }
.nav.scrolled { box-shadow: var(--shadow-sm); }
.nav-inner { max-width: var(--max-width); margin: 0 auto; padding: 0 var(--space-lg); display: flex; align-items: center; justify-content: space-between; height: 64px; }
.nav-brand { font-family: var(--font-display); font-size: 1.35rem; font-weight: 700; color: var(--color-ink); letter-spacing: -0.02em; }
.nav-brand span { color: var(--color-gold); }
.nav-links { display: flex; align-items: center; gap: var(--space-xl); list-style: none; }
.nav-links a { font-size: 0.875rem; font-weight: 500; color: var(--color-ink-soft); letter-spacing: 0.02em; text-transform: uppercase; position: relative; padding: var(--space-xs) 0; }
.nav-links a::after { content: ''; position: absolute; bottom: -2px; left: 0; width: 0; height: 2px; background: var(--color-gold); transition: width var(--transition); }
.nav-links a:hover::after, .nav-links a.active::after { width: 100%; }
.nav-links a:hover { color: var(--color-ink); }
.nav-dropdown { position: relative; }
.nav-dropdown-trigger { cursor: pointer; display: flex; align-items: center; gap: 4px; }
.nav-dropdown-trigger::after { content: ''; border: 4px solid transparent; border-top-color: var(--color-ink-muted); margin-top: 2px; }
.nav-dropdown-menu { position: absolute; top: calc(100% + 12px); left: 50%; transform: translateX(-50%); background: var(--color-white); border: 1px solid var(--color-border-light); border-radius: var(--radius-md); box-shadow: var(--shadow-lg); padding: var(--space-sm) 0; min-width: 220px; opacity: 0; visibility: hidden; transition: all var(--transition); }
.nav-dropdown:hover .nav-dropdown-menu { opacity: 1; visibility: visible; }
.nav-dropdown-menu a { display: block; padding: var(--space-sm) var(--space-lg); font-size: 0.85rem; text-transform: none; letter-spacing: 0; color: var(--color-ink-soft); }
.nav-dropdown-menu a:hover { background: var(--color-surface-alt); color: var(--color-ink); }
.nav-dropdown-menu a::after { display: none; }
.nav-toggle { display: none; background: none; border: none; cursor: pointer; padding: var(--space-sm); }
.nav-toggle span { display: block; width: 22px; height: 2px; background: var(--color-ink); margin: 5px 0; transition: all var(--transition); }
@media (max-width: 900px) {
  .nav-toggle { display: block; }
  .nav-links { position: fixed; top: 64px; left: 0; right: 0; bottom: 0; background: var(--color-surface); flex-direction: column; padding: var(--space-xl); gap: var(--space-lg); transform: translateX(100%); transition: transform var(--transition); }
  .nav-links.open { transform: translateX(0); }
  .nav-dropdown-menu { position: static; transform: none; box-shadow: none; border: none; background: var(--color-surface-alt); border-radius: var(--radius-sm); margin-top: var(--space-sm); opacity: 1; visibility: visible; display: none; }
  .nav-dropdown.open .nav-dropdown-menu { display: block; }
}
.hero { min-height: 85vh; display: flex; align-items: center; position: relative; padding-top: 64px; overflow: hidden; }
.hero::before { content: ''; position: absolute; top: 0; left: 0; right: 0; bottom: 0; background: radial-gradient(ellipse at 20% 50%, rgba(26,82,118,0.06) 0%, transparent 60%), radial-gradient(ellipse at 80% 20%, rgba(184,134,11,0.04) 0%, transparent 50%); pointer-events: none; }
.hero-content { position: relative; z-index: 1; }
.hero-eyebrow { font-family: var(--font-mono); font-size: 0.75rem; font-weight: 500; letter-spacing: 0.15em; text-transform: uppercase; color: var(--color-gold); margin-bottom: var(--space-lg); display: flex; align-items: center; gap: var(--space-sm); }
.hero-eyebrow::before { content: ''; width: 32px; height: 1px; background: var(--color-gold); }
.hero h1 { font-family: var(--font-display); font-size: clamp(2.8rem, 6vw, 4.5rem); font-weight: 700; line-height: 1.08; letter-spacing: -0.03em; color: var(--color-ink); max-width: 800px; margin-bottom: var(--space-lg); }
.hero h1 em { font-style: italic; color: var(--color-accent); }
.hero-subtitle { font-size: 1.15rem; line-height: 1.7; color: var(--color-ink-soft); max-width: 560px; margin-bottom: var(--space-xl); }
.hero-cta { display: inline-flex; align-items: center; gap: var(--space-sm); padding: 14px 28px; background: var(--color-accent-deep); color: var(--color-white); font-weight: 600; font-size: 0.9rem; border-radius: var(--radius-sm); letter-spacing: 0.02em; transition: all var(--transition); }
.hero-cta:hover { background: var(--color-accent); color: var(--color-white); transform: translateY(-1px); box-shadow: var(--shadow-md); }
.hero-cta svg { width: 16px; height: 16px; }
.page-hero { padding: calc(64px + var(--space-3xl)) 0 var(--space-2xl); background: var(--color-accent-deep); color: var(--color-white); position: relative; overflow: hidden; }
.page-hero::after { content: ''; position: absolute; top: 0; right: -10%; width: 50%; height: 100%; background: radial-gradient(ellipse, rgba(184,134,11,0.1) 0%, transparent 70%); pointer-events: none; }
.page-hero .hero-eyebrow { color: var(--color-gold-soft); }
.page-hero h1 { font-family: var(--font-display); font-size: clamp(2.2rem, 5vw, 3.5rem); font-weight: 700; line-height: 1.1; letter-spacing: -0.02em; color: var(--color-white); max-width: 700px; }
.page-hero p { margin-top: var(--space-md); font-size: 1.05rem; color: rgba(255,255,255,0.75); max-width: 560px; }
.section { padding: var(--space-3xl) 0; }
.section-alt { background: var(--color-surface-alt); }
.section-label { font-family: var(--font-mono); font-size: 0.7rem; font-weight: 500; letter-spacing: 0.15em; text-transform: uppercase; color: var(--color-gold); margin-bottom: var(--space-md); display: flex; align-items: center; gap: var(--space-sm); }
.section-label::before { content: ''; width: 20px; height: 1px; background: var(--color-gold); }
.section h2 { font-family: var(--font-display); font-size: clamp(1.8rem, 3.5vw, 2.6rem); font-weight: 700; line-height: 1.15; letter-spacing: -0.02em; color: var(--color-ink); margin-bottom: var(--space-lg); }
.topic-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(340px, 1fr)); gap: var(--space-lg); margin-top: var(--space-xl); }
.topic-card { background: var(--color-surface-card); border: 1px solid var(--color-border-light); border-radius: var(--radius-md); padding: var(--space-xl); transition: all var(--transition); position: relative; overflow: hidden; text-decoration: none; display: block; }
.topic-card::before { content: ''; position: absolute; top: 0; left: 0; width: 3px; height: 100%; background: var(--color-accent); transform: scaleY(0); transform-origin: bottom; transition: transform var(--transition); }
.topic-card:hover { border-color: var(--color-border); box-shadow: var(--shadow-md); transform: translateY(-2px); color: inherit; }
.topic-card:hover::before { transform: scaleY(1); }
.topic-card-icon { width: 40px; height: 40px; border-radius: var(--radius-sm); background: var(--color-accent-light); display: flex; align-items: center; justify-content: center; margin-bottom: var(--space-md); font-size: 1.2rem; }
.topic-card h3 { font-family: var(--font-display); font-size: 1.35rem; font-weight: 700; color: var(--color-ink); margin-bottom: var(--space-sm); }
.topic-card p { font-size: 0.9rem; color: var(--color-ink-muted); line-height: 1.6; margin-bottom: var(--space-md); }
.topic-card-link { font-size: 0.8rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.08em; color: var(--color-accent); display: inline-flex; align-items: center; gap: 6px; }
.topic-card-link::after { content: '\2192'; transition: transform var(--transition); }
.topic-card:hover .topic-card-link::after { transform: translateX(4px); }
.pillar-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: var(--space-lg); margin-top: var(--space-xl); }
@media (max-width: 768px) { .pillar-grid { grid-template-columns: 1fr; } }
.pillar-card { text-align: center; padding: var(--space-2xl) var(--space-lg); background: var(--color-accent-deep); color: var(--color-white); border-radius: var(--radius-md); position: relative; overflow: hidden; }
.pillar-card::after { content: ''; position: absolute; bottom: 0; left: 0; right: 0; height: 3px; background: var(--color-gold); }
.pillar-number { font-family: var(--font-display); font-size: 3.5rem; font-weight: 700; color: var(--color-gold); line-height: 1; margin-bottom: var(--space-md); }
.pillar-card h3 { font-family: var(--font-display); font-size: 1.3rem; font-weight: 600; margin-bottom: var(--space-sm); }
.pillar-card p { font-size: 0.9rem; color: rgba(255,255,255,0.7); line-height: 1.6; }
.article { padding: var(--space-3xl) 0; }
.article-content { max-width: var(--content-width); margin: 0 auto; }
.article-content h2 { font-family: var(--font-display); font-size: 1.8rem; font-weight: 700; color: var(--color-ink); margin-top: var(--space-2xl); margin-bottom: var(--space-md); padding-top: var(--space-lg); border-top: 1px solid var(--color-border-light); }
.article-content h3 { font-family: var(--font-display); font-size: 1.4rem; font-weight: 700; color: var(--color-ink); margin-top: var(--space-xl); margin-bottom: var(--space-md); }
.article-content p { margin-bottom: var(--space-md); color: var(--color-ink-soft); }
.article-content ul, .article-content ol { margin-bottom: var(--space-md); padding-left: var(--space-lg); color: var(--color-ink-soft); }
.article-content li { margin-bottom: var(--space-sm); }
.article-content li strong { color: var(--color-ink); }
.article-content hr { border: none; height: 1px; background: var(--color-border-light); margin: var(--space-xl) 0; }
.article-content a { color: var(--color-accent); text-decoration: underline; text-underline-offset: 3px; }
.concept-block { background: var(--color-surface-alt); border-left: 3px solid var(--color-accent); padding: var(--space-lg) var(--space-xl); border-radius: 0 var(--radius-md) var(--radius-md) 0; margin: var(--space-lg) 0; }
.concept-block .label { font-family: var(--font-mono); font-size: 0.7rem; font-weight: 500; letter-spacing: 0.1em; text-transform: uppercase; color: var(--color-accent); margin-bottom: var(--space-xs); }
.concept-block .value { font-family: var(--font-display); font-size: 1.2rem; font-weight: 600; color: var(--color-ink); }
.stat-row { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: var(--space-md); margin: var(--space-lg) 0; }
.stat-item { background: var(--color-white); border: 1px solid var(--color-border-light); border-radius: var(--radius-md); padding: var(--space-lg); text-align: center; }
.stat-item .number { font-family: var(--font-display); font-size: 2rem; font-weight: 700; color: var(--color-accent); line-height: 1; }
.stat-item .desc { font-size: 0.8rem; color: var(--color-ink-muted); margin-top: var(--space-xs); }
.article-content table { width: 100%; border-collapse: collapse; margin: var(--space-lg) 0; font-size: 0.9rem; }
.article-content th { background: var(--color-accent-deep); color: var(--color-white); padding: var(--space-sm) var(--space-md); text-align: left; font-weight: 600; font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.05em; }
.article-content td { padding: var(--space-sm) var(--space-md); border-bottom: 1px solid var(--color-border-light); color: var(--color-ink-soft); }
.article-content tr:last-child td { font-weight: 600; color: var(--color-ink); }
.article-content tbody tr:hover { background: var(--color-surface-alt); }
.footer { background: var(--color-ink); color: rgba(255,255,255,0.6); padding: var(--space-2xl) 0 var(--space-xl); }
.footer-inner { max-width: var(--max-width); margin: 0 auto; padding: 0 var(--space-lg); display: grid; grid-template-columns: 1fr 1fr; gap: var(--space-xl); align-items: end; }
@media (max-width: 600px) { .footer-inner { grid-template-columns: 1fr; text-align: center; } }
.footer-brand { font-family: var(--font-display); font-size: 1.2rem; font-weight: 700; color: var(--color-white); margin-bottom: var(--space-sm); }
.footer p { font-size: 0.85rem; line-height: 1.6; }
.footer-links { text-align: right; list-style: none; display: flex; gap: var(--space-lg); justify-content: flex-end; flex-wrap: wrap; }
@media (max-width: 600px) { .footer-links { justify-content: center; } }
.footer-links a { font-size: 0.85rem; color: rgba(255,255,255,0.5); }
.footer-links a:hover { color: var(--color-gold); }
@keyframes fadeUp { from { opacity: 0; transform: translateY(24px); } to { opacity: 1; transform: translateY(0); } }
.animate-in { opacity: 0; animation: fadeUp 0.7s ease forwards; }
.delay-1 { animation-delay: 0.1s; } .delay-2 { animation-delay: 0.2s; } .delay-3 { animation-delay: 0.3s; }
.breadcrumb { font-size: 0.8rem; color: rgba(255,255,255,0.5); margin-bottom: var(--space-md); }
.breadcrumb a { color: rgba(255,255,255,0.5); } .breadcrumb a:hover { color: var(--color-gold); }
.breadcrumb span { margin: 0 var(--space-sm); }
.contact-link { display: inline-flex; align-items: center; gap: var(--space-sm); padding: 16px 32px; background: var(--color-accent-deep); color: var(--color-white); font-weight: 600; border-radius: var(--radius-sm); font-size: 1rem; transition: all var(--transition); }
.contact-link:hover { background: var(--color-accent); color: var(--color-white); transform: translateY(-1px); box-shadow: var(--shadow-md); }
.post-nav { display: grid; grid-template-columns: 1fr 1fr; gap: var(--space-lg); margin-top: var(--space-2xl); padding-top: var(--space-xl); border-top: 1px solid var(--color-border-light); }
.post-nav a { display: block; padding: var(--space-lg); background: var(--color-surface-alt); border-radius: var(--radius-md); transition: all var(--transition); text-decoration: none; }
.post-nav a:hover { background: var(--color-accent-light); }
.post-nav-label { font-family: var(--font-mono); font-size: 0.7rem; letter-spacing: 0.1em; text-transform: uppercase; color: var(--color-ink-muted); margin-bottom: var(--space-xs); }
.post-nav-title { font-family: var(--font-display); font-size: 1.1rem; font-weight: 600; color: var(--color-ink); }
.post-nav a:last-child { text-align: right; }
@media (max-width: 600px) { .post-nav { grid-template-columns: 1fr; } }
CSSEOF

# ============================================================
# JavaScript
# ============================================================
cat > js/main.js << 'JSEOF'
const nav = document.querySelector('.nav');
window.addEventListener('scroll', () => { nav?.classList.toggle('scrolled', window.scrollY > 20); });
const toggle = document.querySelector('.nav-toggle');
const links = document.querySelector('.nav-links');
toggle?.addEventListener('click', () => { links?.classList.toggle('open'); });
document.querySelectorAll('.nav-dropdown-trigger').forEach(trigger => {
  trigger.addEventListener('click', (e) => { if (window.innerWidth <= 900) { e.preventDefault(); trigger.closest('.nav-dropdown')?.classList.toggle('open'); } });
});
document.querySelectorAll('.nav-links a:not(.nav-dropdown-trigger)').forEach(link => { link.addEventListener('click', () => { links?.classList.remove('open'); }); });
const observer = new IntersectionObserver((entries) => { entries.forEach(entry => { if (entry.isIntersecting) { entry.target.classList.add('animate-in'); observer.unobserve(entry.target); } }); }, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' });
document.querySelectorAll('.observe').forEach(el => observer.observe(el));
const currentPath = window.location.pathname.replace(/\/$/, '').split('/').pop() || 'index';
document.querySelectorAll('.nav-links a, .sidebar-nav a').forEach(link => { const href = link.getAttribute('href')?.replace(/\/$/, '').split('/').pop()?.replace('.html', '') || ''; if (href === currentPath || (href === 'index' && currentPath === '')) { link.classList.add('active'); } });
JSEOF

# ============================================================
# NAV SNIPPET (reused across all pages)
# ============================================================
NAV='<nav class="nav"><div class="nav-inner"><a href="index.html" class="nav-brand">Chris <span>Crossett</span></a><button class="nav-toggle" aria-label="Menu"><span></span><span></span><span></span></button><ul class="nav-links"><li class="nav-dropdown"><a href="#" class="nav-dropdown-trigger">Government</a><div class="nav-dropdown-menu"><a href="federal-reform.html">Federal Reform Overview</a><a href="federal-taxes.html">Federal Taxes</a><a href="national-sales-tax.html">National Sales Tax</a><a href="federal-spending.html">Federal Spending</a><a href="non-financial-changes.html">Non-Financial Reforms</a><a href="privatization.html">Privatization</a><a href="state-govt.html">State Government</a><a href="county-govt.html">County Government</a><a href="local-govt.html">Local Government</a></div></li><li class="nav-dropdown"><a href="#" class="nav-dropdown-trigger">Finance</a><div class="nav-dropdown-menu"><a href="mortgages.html">Mortgage Reform</a><a href="real-estate.html">Real Estate</a><a href="daily-finance.html">Daily Finance</a></div></li><li><a href="about.html">About</a></li><li><a href="contact.html">Contact</a></li></ul></div></nav>'

FOOTER='<footer class="footer"><div class="footer-inner"><div><div class="footer-brand">Chris Crossett</div><p>Ideas for major societal leaps forward.</p></div><ul class="footer-links"><li><a href="about.html">About</a></li><li><a href="contact.html">Contact</a></li><li><a href="federal-reform.html">Government</a></li><li><a href="mortgages.html">Finance</a></li></ul></div></footer><script src="js/main.js"></script>'

HEAD='<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><link rel="stylesheet" href="css/style.css"><link rel="icon" href="data:image/svg+xml,<svg xmlns='"'"'http://www.w3.org/2000/svg'"'"' viewBox='"'"'0 0 100 100'"'"'><text y='"'"'.9em'"'"' font-size='"'"'90'"'"'>◆</text></svg>"'

# ============================================================
# PAGES
# ============================================================

# Federal Reform
cat > federal-reform.html << PAGEEOF
<!DOCTYPE html><html lang="en"><head>${HEAD}<title>Federal Government Reform — Chris Crossett</title></head><body>
${NAV}
<section class="page-hero"><div class="container"><div class="breadcrumb"><a href="index.html">Home</a> <span>›</span> Government Reform</div><div class="hero-eyebrow animate-in">Federal Government</div><h1 class="animate-in delay-1">Federal Gov't Reform</h1><p class="animate-in delay-2">An approach for fiscal responsibility at all levels of government.</p></div></section>
<section class="article"><div class="container"><div class="article-content">
<p>I am a fiscal conservative. I am a strong believer in balanced budgets, especially for governments. My undergraduate degree is in Accounting, with a Masters in Business Administration. I have a few ideas to help put our Federal Government on track for financial success.</p>
<div class="concept-block"><div class="label">Guiding Principle</div><div class="value">"Keep your eye on one thing and one thing only: how much government is spending, because that's the true tax."</div><p style="margin-top:8px;font-size:0.85rem;color:var(--color-ink-muted);">— Milton Friedman, Economist</p></div>
<h2>Step One: Overhaul the Tax Code</h2><p>Replace all federal taxes with a <a href="national-sales-tax.html">5% National Sales Tax</a> and a 5% Corporate Tax (on Net Sales).</p>
<h2>Step Two: Cut Spending to Match Revenue</h2><p>Cut total government outlays to match the revenue generated by the 10% combined National Sales Tax.</p>
<h2>Step Three: Pay Off All Debts</h2><p>Allocate 50% of taxes collected into paying off debts — including Social Security, Medicare, and Medicaid obligations. When all debt is paid off, lower tax rates to 5%.</p>
<hr><h2>Explore the Details</h2>
<div class="topic-grid" style="margin-top:var(--space-lg);"><a href="federal-taxes.html" class="topic-card"><h3>Federal Tax Reform</h3><p>Detailed proposals for replacing income, payroll, excise, and corporate taxes.</p><span class="topic-card-link">Read more</span></a><a href="federal-spending.html" class="topic-card"><h3>Federal Spending</h3><p>Budget allocation framework and social program sunset plans.</p><span class="topic-card-link">Read more</span></a><a href="privatization.html" class="topic-card"><h3>Privatization</h3><p>Programs and assets to be sold to reduce expenses and generate revenue.</p><span class="topic-card-link">Read more</span></a></div>
</div></div></section>
${FOOTER}</body></html>
PAGEEOF

# Federal Taxes
cat > federal-taxes.html << PAGEEOF
<!DOCTYPE html><html lang="en"><head>${HEAD}<title>Individual Federal Income Tax — Chris Crossett</title></head><body>
${NAV}
<section class="page-hero"><div class="container"><div class="breadcrumb"><a href="index.html">Home</a> <span>›</span> <a href="federal-reform.html">Government</a> <span>›</span> Federal Taxes</div><div class="hero-eyebrow animate-in">Tax Reform</div><h1 class="animate-in delay-1">Individual Federal Income Tax</h1><p class="animate-in delay-2">Replacing all federal taxes with a simplified system that eliminates fraud and reduces overhead.</p></div></section>
<section class="article"><div class="container"><div class="article-content">
<div class="concept-block"><div class="label">Concept</div><div class="value">Use a National Sales Tax to replace Individual Federal Income Taxes</div></div>
<div class="stat-row"><div class="stat-item"><div class="number">\$2.2T</div><div class="desc">Current Tax Revenue / Year</div></div><div class="stat-item"><div class="number">36%</div><div class="desc">of Federal Tax Revenue</div></div><div class="stat-item"><div class="number">5%</div><div class="desc">Proposed National Sales Tax</div></div></div>
<h3>Solution: Set the National Sales Tax to 5.0%</h3>
<ul><li>Tax to be levied on all new purchases (items where tax has not been previously levied)</li><li>No more filing individual income taxes</li><li>Easier for employers to pay individuals</li><li>IRS not needed for tax compliance</li></ul>
<hr><h2>Payroll Taxes</h2>
<div class="concept-block"><div class="label">Concept</div><div class="value">End all Payroll Taxes</div></div>
<div class="stat-row"><div class="stat-item"><div class="number">\$1.6T</div><div class="desc">Current Payroll Tax Revenue</div></div><div class="stat-item"><div class="number">\$0</div><div class="desc">New Revenue to Federal Govt</div></div></div>
<ul><li>Social Security to be considered part of debt and paid with 5% of National Sales Tax</li><li>Federal Government to refund all prior contributions by individuals &amp; businesses</li><li>Individuals already in retirement get a statement of total funds contributed versus withdrawn</li></ul>
<hr><h2>Excise Taxes</h2><p>Eliminate all Excise Taxes. The States are closer to assess the needs of their state as it relates to Gas, Alcohol, Tobacco, Airports.</p>
<hr><h2>Corporate Taxes</h2>
<div class="stat-row"><div class="stat-item"><div class="number">\$420B</div><div class="desc">Current Corporate Tax Revenue</div></div><div class="stat-item"><div class="number">5%</div><div class="desc">Proposed Rate on Net Sales</div></div></div>
<p>Set the Corporate Tax to 5.0% of Net Sales (Gross Sales less Returns and Allowances). This significantly reduces the overhead and complexity of corporate tax.</p>
<hr><p><strong>These plans eliminate the entire current tax code and replace it with a very simple tax system.</strong></p>
<div class="post-nav"><a href="federal-reform.html"><div class="post-nav-label">← Previous</div><div class="post-nav-title">Federal Reform Overview</div></a><a href="national-sales-tax.html"><div class="post-nav-label">Next →</div><div class="post-nav-title">National Sales Tax</div></a></div>
</div></div></section>
${FOOTER}</body></html>
PAGEEOF

# National Sales Tax
cat > national-sales-tax.html << PAGEEOF
<!DOCTYPE html><html lang="en"><head>${HEAD}<title>National Sales Tax — Chris Crossett</title></head><body>
${NAV}
<section class="page-hero"><div class="container"><div class="breadcrumb"><a href="index.html">Home</a> <span>›</span> <a href="federal-reform.html">Government</a> <span>›</span> National Sales Tax</div><div class="hero-eyebrow animate-in">Tax Reform</div><h1 class="animate-in delay-1">National Sales Tax</h1><p class="animate-in delay-2">A 10% national sales tax replacing all federal taxes — creating a hard ceiling to government spending.</p></div></section>
<section class="article"><div class="container"><div class="article-content">
<div class="concept-block"><div class="label">Concept</div><div class="value">Use a National Sales Tax of 10% replacing all federal taxes. No program survives without revenue. Our 10% sales tax provides a hard ceiling to spending.</div></div>
<div class="stat-row"><div class="stat-item"><div class="number">~\$4.7T</div><div class="desc">Current Federal Tax Revenue</div></div><div class="stat-item"><div class="number">~\$19T</div><div class="desc">U.S. Consumer Expenditures</div></div><div class="stat-item"><div class="number">~\$1.9T</div><div class="desc">Est. Revenue from 10% Tax</div></div></div>
<h3>Advantages</h3><ul><li>Simple process to calculate and file returns</li><li>Does not give favorability to one industry or business over another</li><li><strong>Exempt all Groceries</strong> (Food &amp; Beverages)</li></ul>
<div class="post-nav"><a href="federal-taxes.html"><div class="post-nav-label">← Previous</div><div class="post-nav-title">Federal Taxes</div></a><a href="federal-spending.html"><div class="post-nav-label">Next →</div><div class="post-nav-title">Federal Spending</div></a></div>
</div></div></section>
${FOOTER}</body></html>
PAGEEOF

# Federal Spending
cat > federal-spending.html << PAGEEOF
<!DOCTYPE html><html lang="en"><head>${HEAD}<title>Federal Government Spending — Chris Crossett</title></head><body>
${NAV}
<section class="page-hero"><div class="container"><div class="breadcrumb"><a href="index.html">Home</a> <span>›</span> <a href="federal-reform.html">Government</a> <span>›</span> Federal Spending</div><div class="hero-eyebrow animate-in">Budgeting &amp; Spending</div><h1 class="animate-in delay-1">Federal Government Spending</h1><p class="animate-in delay-2">Creating a balanced budget and sunsetting unsustainable social programs.</p></div></section>
<section class="article"><div class="container"><div class="article-content">
<p>The US Federal Government has such a high opportunity for making the lives of citizens better, but due to partisan behavior and lack of guiding principles, has lost its way.</p>
<h2>Budget Allocation: 10% National Sales Tax</h2>
<table><thead><tr><th>Allocation</th><th>%</th><th>Purpose</th></tr></thead><tbody><tr><td>National Debt</td><td>2%</td><td>Pay down existing debt</td></tr><tr><td>Social Security Debt</td><td>2%</td><td>Repayments to individuals</td></tr><tr><td>Medicare Debt</td><td>1%</td><td>Repayments to individuals</td></tr><tr><td>Defense &amp; Related</td><td>4%</td><td>As directed by the Constitution</td></tr><tr><td>Other / Non-Defense</td><td>1%</td><td>All remaining functions</td></tr><tr><td><strong>Total</strong></td><td><strong>10%</strong></td><td></td></tr></tbody></table>
<p>Once all debts are paid off, reduce the National Sales Tax to 5%.</p>
<hr><h2>Social Programs Reform</h2>
<h3>How to Sunset Social Security</h3><ul><li>Provide 18 months notice</li><li>End employment of all SSA workers; end employee/employer contributions</li><li>For those currently collecting: fund an IRA with Net Balance</li><li>For those not yet receiving: fund IRA starting with those closest to retirement</li></ul>
<h3>How to Sunset Medicare</h3><ul><li>Provide 18 months notice</li><li>End all administration employment and contributions</li><li>Fund a Health Savings Account (HSA) with Net Balance</li></ul>
<h3>How to Sunset Medicaid &amp; Federal Unemployment</h3><p>Provide 18 month notice and end in entirety.</p>
<div class="post-nav"><a href="national-sales-tax.html"><div class="post-nav-label">← Previous</div><div class="post-nav-title">National Sales Tax</div></a><a href="non-financial-changes.html"><div class="post-nav-label">Next →</div><div class="post-nav-title">Non-Financial Changes</div></a></div>
</div></div></section>
${FOOTER}</body></html>
PAGEEOF

# Non-Financial Changes
cat > non-financial-changes.html << PAGEEOF
<!DOCTYPE html><html lang="en"><head>${HEAD}<title>Non-Financial Changes — Chris Crossett</title></head><body>
${NAV}
<section class="page-hero"><div class="container"><div class="breadcrumb"><a href="index.html">Home</a> <span>›</span> <a href="federal-reform.html">Government</a> <span>›</span> Non-Financial Reforms</div><div class="hero-eyebrow animate-in">Structural Reform</div><h1 class="animate-in delay-1">Non-Financial Changes</h1><p class="animate-in delay-2">Critical structural reforms beyond the budget.</p></div></section>
<section class="article"><div class="container"><div class="article-content">
<h2>Term Limits</h2><p>Cap at <strong>5 terms (10 years) for the House</strong> and <strong>2 terms (12 years) for the Senate</strong>. Fresh ideas require fresh people.</p>
<h2>U.S. Mint</h2><ul><li>Embrace Cryptocurrencies as legal tender</li><li>Cease making \$1 and \$5 bills — replace with coins</li><li>Cease making the 1 cent coin</li><li>Create a "coin card" smart card for change</li></ul>
<h2>Federal Reserve</h2><ul><li>Eliminate the Federal Reserve; use assets to pay down debt</li><li>Adopt Cryptocurrencies like Bitcoin for monetary supply</li></ul>
<h2>Homeland Security / CIA / FBI</h2><p>Combine all three into one entity under the Defense Department, reducing duplicated jobs.</p>
<h2>Repeal Tax Code</h2><ul><li>Remove limits on Retirement contributions</li><li>Remove limits on Health Savings Accounts</li><li>Repeal anything paid "after tax"</li></ul>
<div class="post-nav"><a href="federal-spending.html"><div class="post-nav-label">← Previous</div><div class="post-nav-title">Federal Spending</div></a><a href="privatization.html"><div class="post-nav-label">Next →</div><div class="post-nav-title">Privatization</div></a></div>
</div></div></section>
${FOOTER}</body></html>
PAGEEOF

# Privatization
cat > privatization.html << PAGEEOF
<!DOCTYPE html><html lang="en"><head>${HEAD}<title>Privatization — Chris Crossett</title></head><body>
${NAV}
<section class="page-hero"><div class="container"><div class="breadcrumb"><a href="index.html">Home</a> <span>›</span> <a href="federal-reform.html">Government</a> <span>›</span> Privatization</div><div class="hero-eyebrow animate-in">Government Reform</div><h1 class="animate-in delay-1">Privatization</h1><p class="animate-in delay-2">Federal assets and programs to sell or transfer to reduce expenses and generate revenue.</p></div></section>
<section class="article"><div class="container"><div class="article-content">
<h2>National Parks / US Forest Service</h2><p>Sell to businesses or states. Businesses can run parks more efficiently with access to capital for improvements.</p>
<h2>United States Postal Service</h2><p>Sell the USPS. FedEx, UPS, and others already do a fine job.</p>
<h2>Bureau of Land Management</h2><p>Sell all 247.3 million acres of BLM land in 12 western states.</p>
<h2>Lending Programs</h2><p>Sell all Student Loans, Home Loans, and SBA Loans. The federal government should not be in the lending business.</p>
<h2>Department of Education</h2><p>Eliminate the \$70 billion expense. Education should be managed by the states. Commerce, Energy, IRS, and EPA can be reduced 50-90%.</p>
<h2>Foreign Military</h2><p>Either charge foreign governments 21.5% for services provided, or sell bases to local governments.</p>
<h2>Transportation / Fuel Tax</h2><p>Combine fuel taxes and add to state tax. States manage their own roads.</p>
<h2>Airports &amp; Trains</h2><p>Sell airports and Amtrak. Maintain a small FAA for safety oversight.</p>
<h2>Government Buildings</h2><p>Sell buildings from closing departments, or sell and lease back.</p>
<h2>Education Format</h2><p>Move learning to tablet devices. Video lectures by top educators per subject per county. Electronic homework and testing. Students learn at their own pace.</p>
<div class="post-nav"><a href="non-financial-changes.html"><div class="post-nav-label">← Previous</div><div class="post-nav-title">Non-Financial Changes</div></a><a href="state-govt.html"><div class="post-nav-label">Next →</div><div class="post-nav-title">State Government</div></a></div>
</div></div></section>
${FOOTER}</body></html>
PAGEEOF

# State Govt
cat > state-govt.html << PAGEEOF
<!DOCTYPE html><html lang="en"><head>${HEAD}<title>State Government Reform — Chris Crossett</title></head><body>
${NAV}
<section class="page-hero"><div class="container"><div class="breadcrumb"><a href="index.html">Home</a> <span>›</span> <a href="federal-reform.html">Government</a> <span>›</span> State Government</div><div class="hero-eyebrow animate-in">State Reform</div><h1 class="animate-in delay-1">State Government</h1><p class="animate-in delay-2">Fundamental reforms to achieve balanced budgets funded by sales tax revenue alone.</p></div></section>
<section class="article"><div class="container"><div class="article-content">
<h2>Create a Budget</h2><p>Fund the entire state government from current sales tax revenues.</p>
<h2>Health Care</h2><p>Not the state's responsibility. Cut health care administration costs to zero.</p>
<h2>Education</h2><p>Sell all state colleges and universities to private entities for better competition on pricing and quality.</p>
<h2>Transportation &amp; Public Safety</h2><p>Combine state police with county departments. State DOT receives doubled budget from combined fuel taxes.</p>
<h2>DMV Reform</h2><p>Registration only on transfer of ownership. Replace license plates with GPS devices under the hood.</p>
<h2>Courts</h2><p>Process nearly all cases online where judges review and rule electronically.</p>
<h2>State Bonds</h2><p>Repeal all state bonding. States should not incur debt.</p>
<h2>State Taxes</h2><p>Repeal all taxes except Motor Fuel and a fixed 7.5% Sales Tax.</p>
<div class="post-nav"><a href="privatization.html"><div class="post-nav-label">← Previous</div><div class="post-nav-title">Privatization</div></a><a href="county-govt.html"><div class="post-nav-label">Next →</div><div class="post-nav-title">County Government</div></a></div>
</div></div></section>
${FOOTER}</body></html>
PAGEEOF

# County Govt
cat > county-govt.html << PAGEEOF
<!DOCTYPE html><html lang="en"><head>${HEAD}<title>County Government Reform — Chris Crossett</title></head><body>
${NAV}
<section class="page-hero"><div class="container"><div class="breadcrumb"><a href="index.html">Home</a> <span>›</span> <a href="federal-reform.html">Government</a> <span>›</span> County Government</div><div class="hero-eyebrow animate-in">County Reform</div><h1 class="animate-in delay-1">County Government</h1><p class="animate-in delay-2">A shared services model to consolidate city functions and reduce spending.</p></div></section>
<section class="article"><div class="container"><div class="article-content">
<h2>Shared Services</h2><p>Move Finance, Police, Fire, Road Crew, Parks, and Planning to the county level. Instead of 10 police chiefs for 10 cities, have 1. Cut workforce 50-60% while maintaining service levels.</p>
<h2>Property Taxes</h2><p>Repeal all property taxes. Fund with county portion of sales taxes only.</p>
<h2>County Bonds</h2><p>Repeal all county bonding and pay back all debts. Counties should not incur debt.</p>
<div class="post-nav"><a href="state-govt.html"><div class="post-nav-label">← Previous</div><div class="post-nav-title">State Government</div></a><a href="local-govt.html"><div class="post-nav-label">Next →</div><div class="post-nav-title">Local Government</div></a></div>
</div></div></section>
${FOOTER}</body></html>
PAGEEOF

# Local Govt
cat > local-govt.html << PAGEEOF
<!DOCTYPE html><html lang="en"><head>${HEAD}<title>Local Government Reform — Chris Crossett</title></head><body>
${NAV}
<section class="page-hero"><div class="container"><div class="breadcrumb"><a href="index.html">Home</a> <span>›</span> <a href="federal-reform.html">Government</a> <span>›</span> Local Government</div><div class="hero-eyebrow animate-in">Local Reform</div><h1 class="animate-in delay-1">Local Government</h1><p class="animate-in delay-2">Consolidating city services to the county level and moving remaining positions to voluntary roles.</p></div></section>
<section class="article"><div class="container"><div class="article-content">
<div class="stat-row"><div class="stat-item"><div class="number">78%</div><div class="desc">City expenses that are Labor &amp; Benefits</div></div></div>
<p>With essential services moved to the county, remaining city positions (mayor, council, manager) become voluntary. By cutting 78% of labor costs, sales tax increases would be minimal — a well-run county could actually cut its tax rate.</p>
<h2>City Bonds</h2><p>Repeal all city bonding and pay off debts. Cities should not incur any debt.</p>
<h2>City Vehicles</h2><p>Return all city vehicles to eliminate this cost.</p>
<div class="post-nav"><a href="county-govt.html"><div class="post-nav-label">← Previous</div><div class="post-nav-title">County Government</div></a><a href="mortgages.html"><div class="post-nav-label">Next →</div><div class="post-nav-title">Mortgage Reform</div></a></div>
</div></div></section>
${FOOTER}</body></html>
PAGEEOF

# Mortgages
cat > mortgages.html << PAGEEOF
<!DOCTYPE html><html lang="en"><head>${HEAD}<title>Mortgage Reform — Chris Crossett</title></head><body>
${NAV}
<section class="page-hero"><div class="container"><div class="breadcrumb"><a href="index.html">Home</a> <span>›</span> Finance <span>›</span> Mortgages</div><div class="hero-eyebrow animate-in">Financial Technology</div><h1 class="animate-in delay-1">Mortgage Reform</h1><p class="animate-in delay-2">Streamlining the end-to-end mortgage process by eliminating unnecessary intermediaries.</p></div></section>
<section class="article"><div class="container"><div class="article-content">
<p>Fannie Mae and Freddie Mac back over \$5T in mortgages. The current process takes too much time, cost, and effort.</p>
<div class="concept-block"><div class="label">Problem</div><div class="value">Too many people involved, too much cost incurred, and too much time spent when a property changes ownership or is refinanced.</div></div>
<h2>Proposed Solution (Home Purchases)</h2><p>FM/FM could remove nearly all barriers by allowing a quick update to the MBS with new owner and terms. Regional subsidiaries for servicing, title, and appraisal. An online portal and master property database linked to county records.</p>
<div class="stat-row"><div class="stat-item"><div class="number">Time</div><div class="desc">Hours, not weeks</div></div><div class="stat-item"><div class="number">Cost</div><div class="desc">Electronic replaces manual</div></div><div class="stat-item"><div class="number">Truth</div><div class="desc">Single ledger, single source</div></div></div>
<h2>Proposed Solution (Refinances)</h2><p>A new mortgage product: secured line of credit with ability to switch between variable and fixed rates quarterly. Full value of home secured — no need for separate second mortgage or HELOC.</p>
<h2>Other Improvements</h2><ul><li>Allow payments via stored card</li><li>Flexible payment dates</li><li>Eliminate PMI (add to interest rate)</li><li>Annual refinance without cost</li><li>Servicing company manages rent collection</li></ul>
<p style="margin-top:var(--space-xl)">Can you help? Email: <a href="mailto:chris@crossett.net">chris@crossett.net</a></p>
<div class="post-nav"><a href="local-govt.html"><div class="post-nav-label">← Previous</div><div class="post-nav-title">Local Government</div></a><a href="real-estate.html"><div class="post-nav-label">Next →</div><div class="post-nav-title">Real Estate</div></a></div>
</div></div></section>
${FOOTER}</body></html>
PAGEEOF

# Real Estate
cat > real-estate.html << PAGEEOF
<!DOCTYPE html><html lang="en"><head>${HEAD}<title>Real Estate Reform — Chris Crossett</title></head><body>
${NAV}
<section class="page-hero"><div class="container"><div class="breadcrumb"><a href="index.html">Home</a> <span>›</span> Finance <span>›</span> Real Estate</div><div class="hero-eyebrow animate-in">Financial Technology</div><h1 class="animate-in delay-1">Real Estate Reform</h1><p class="animate-in delay-2">Empowering sellers with better tools and reducing unnecessary agent costs.</p></div></section>
<section class="article"><div class="container"><div class="article-content">
<div class="concept-block"><div class="label">The Problem</div><div class="value">A home sells for \$500,000 and agents take \$30,000 off the top, plus origination and closing fees.</div></div>
<h2>Solution: More Tools for Sellers</h2>
<h3>Web Portal / Smartphone App</h3><p>Standard photos, virtual walk-throughs, "doll house" views, and scheduling for showings.</p>
<h3>Auction-Style Sales</h3><p>Allow market forces to determine price instead of agents suggesting sellers accept offers. Buyers set time limits to protect their interests.</p>
<h3>National Property Database</h3><p>Managed by FM/FM with all property information: County Records, Builder, Utilities, Year Built, Remodel history.</p>
<h3>Additional Reforms</h3><ul><li>Allow FSBO listings on MLS</li><li>Electronic document generator for offers and acceptances</li></ul>
<p style="margin-top:var(--space-xl)">Can you help? Email: <a href="mailto:chris@crossett.net">chris@crossett.net</a></p>
<div class="post-nav"><a href="mortgages.html"><div class="post-nav-label">← Previous</div><div class="post-nav-title">Mortgage Reform</div></a><a href="daily-finance.html"><div class="post-nav-label">Next →</div><div class="post-nav-title">Daily Finance</div></a></div>
</div></div></section>
${FOOTER}</body></html>
PAGEEOF

# Daily Finance
cat > daily-finance.html << PAGEEOF
<!DOCTYPE html><html lang="en"><head>${HEAD}<title>Daily Finance — Chris Crossett</title></head><body>
${NAV}
<section class="page-hero"><div class="container"><div class="breadcrumb"><a href="index.html">Home</a> <span>›</span> Finance <span>›</span> Daily Finance</div><div class="hero-eyebrow animate-in">Financial Technology</div><h1 class="animate-in delay-1">Daily Finance</h1><p class="animate-in delay-2">Breaking down personal finance into daily income and expenses for clearer money management.</p></div></section>
<section class="article"><div class="container"><div class="article-content">
<p>The idea is to break finance into smaller pieces — daily income and daily expenses — so individuals clearly see their financial spread.</p>
<h2>Changes to Earnings</h2><p>Allow daily payroll payments. Salaried employees are straightforward; hourly workers need a 1-day delay for manager confirmation.</p>
<h2>Changes to Expenses</h2><p>Monthly lenders allow daily payment processing. Variable expenses are amortized over 30 days. Example: a \$3.00 purchase = \$0.10/day for 30 days.</p>
<h2>Daily Overview Example</h2>
<table><thead><tr><th>Category</th><th>Daily Amount</th></tr></thead><tbody><tr><td><strong>Income</strong></td><td><strong>\$150</strong></td></tr><tr><td>Rent</td><td>\$40</td></tr><tr><td>Car Loan</td><td>\$15</td></tr><tr><td>Other Expenses</td><td>\$75</td></tr><tr><td><strong>Total Expenses</strong></td><td><strong>\$130</strong></td></tr><tr><td><strong>Net (Daily Spread)</strong></td><td><strong>\$20/day</strong></td></tr></tbody></table>
<h2>Where to Start</h2><p><strong>Expense Side:</strong> Leverage Apple Card as the starting point. Apple could offer checking/savings and coordinate daily payments to lenders.</p>
<p><strong>Income Side:</strong> Financial institutions process daily payroll electronically. Bonuses spread over time. Commissions paid over the following month.</p>
<div class="post-nav"><a href="real-estate.html"><div class="post-nav-label">← Previous</div><div class="post-nav-title">Real Estate</div></a><a href="about.html"><div class="post-nav-label">Next →</div><div class="post-nav-title">About Me</div></a></div>
</div></div></section>
${FOOTER}</body></html>
PAGEEOF

# About
cat > about.html << PAGEEOF
<!DOCTYPE html><html lang="en"><head>${HEAD}<title>About — Chris Crossett</title></head><body>
${NAV}
<section class="page-hero"><div class="container"><div class="hero-eyebrow animate-in">Background</div><h1 class="animate-in delay-1">About Me</h1><p class="animate-in delay-2">Fiscal conservative. Accounting &amp; Finance professional. Problem solver.</p></div></section>
<section class="article"><div class="container"><div class="article-content">
<p>I am a fiscal conservative. I am a strong believer in balanced budgets, especially for governments. My undergraduate degree is in Accounting, with a Masters in Business Administration.</p>
<p>Early on in my life, I was able to attend Town Halls in Vermont. This was quite a treat and I gained interest in how governments work. This also caused me to want to find solutions to the problems.</p>
<p>I exercise daily and as I do, I take time to critically think about the problems and what the solutions might be. Using this website helps me take my thoughts and "put them on paper" so that I can further my ideas and start to implement solutions.</p>
<div style="margin-top:var(--space-2xl);text-align:center;"><a href="contact.html" class="contact-link">Get in Touch →</a></div>
</div></div></section>
${FOOTER}</body></html>
PAGEEOF

# Contact
cat > contact.html << PAGEEOF
<!DOCTYPE html><html lang="en"><head>${HEAD}<title>Contact — Chris Crossett</title></head><body>
${NAV}
<section class="page-hero"><div class="container"><div class="hero-eyebrow animate-in">Let's Connect</div><h1 class="animate-in delay-1">Contact</h1><p class="animate-in delay-2">Have comments, questions, or want to collaborate?</p></div></section>
<section class="article"><div class="container"><div class="article-content" style="text-align:center;padding:var(--space-3xl) 0;">
<p style="font-size:1.1rem;color:var(--color-ink-soft);margin-bottom:var(--space-xl);">If you have any comments or would just like to talk, please feel free to reach out.</p>
<a href="mailto:chris@crossett.net" class="contact-link">chris@crossett.net</a>
</div></div></section>
${FOOTER}</body></html>
PAGEEOF

echo ""
echo "✅ Setup complete! All files created:"
echo "   - css/style.css"
echo "   - js/main.js"
echo "   - 14 HTML pages"
echo "   - .gitignore, .nojekyll, CNAME"
echo "   - .vscode/settings.json, extensions.json"
echo ""
echo "Run 'npm run dev' to start the local server."
