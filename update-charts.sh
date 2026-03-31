#!/bin/bash
# Run from ~/crossett-site
# Updates federal-taxes.html and federal-spending.html with charts and current data

echo "Updating pages with charts and current data..."

# ============================================================
# Add Chart.js CDN to pages that need it
# We'll embed charts directly in the HTML pages
# ============================================================

NAV='<nav class="nav"><div class="nav-inner"><a href="index.html" class="nav-brand">Chris <span>Crossett</span></a><button class="nav-toggle" aria-label="Menu"><span></span><span></span><span></span></button><ul class="nav-links"><li class="nav-dropdown"><a href="#" class="nav-dropdown-trigger">Government</a><div class="nav-dropdown-menu"><a href="federal-reform.html">Federal Reform Overview</a><a href="federal-taxes.html">Federal Taxes</a><a href="national-sales-tax.html">National Sales Tax</a><a href="federal-spending.html">Federal Spending</a><a href="non-financial-changes.html">Non-Financial Reforms</a><a href="privatization.html">Privatization</a><a href="state-govt.html">State Government</a><a href="county-govt.html">County Government</a><a href="local-govt.html">Local Government</a></div></li><li class="nav-dropdown"><a href="#" class="nav-dropdown-trigger">Finance</a><div class="nav-dropdown-menu"><a href="mortgages.html">Mortgage Reform</a><a href="real-estate.html">Real Estate</a><a href="daily-finance.html">Daily Finance</a></div></li><li><a href="about.html">About</a></li><li><a href="contact.html">Contact</a></li></ul></div></nav>'

FOOTER='<footer class="footer"><div class="footer-inner"><div><div class="footer-brand">Chris Crossett</div><p>Ideas for major societal leaps forward.</p></div><ul class="footer-links"><li><a href="about.html">About</a></li><li><a href="contact.html">Contact</a></li><li><a href="federal-reform.html">Government</a></li><li><a href="mortgages.html">Finance</a></li></ul></div></footer><script src="js/main.js"></script>'

HEAD='<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><link rel="stylesheet" href="css/style.css"><link rel="icon" href="data:image/svg+xml,<svg xmlns='"'"'http://www.w3.org/2000/svg'"'"' viewBox='"'"'0 0 100 100'"'"'><text y='"'"'.9em'"'"' font-size='"'"'90'"'"'>◆</text></svg>"'

# Add chart styles to CSS
cat >> css/style.css << 'CHARTCSS'

/* Chart Containers */
.chart-container { position: relative; margin: var(--space-xl) 0; padding: var(--space-lg); background: var(--color-white); border: 1px solid var(--color-border-light); border-radius: var(--radius-md); }
.chart-container canvas { max-height: 400px; }
.chart-title { font-family: var(--font-display); font-size: 1.3rem; font-weight: 700; color: var(--color-ink); margin-bottom: var(--space-md); text-align: center; }
.chart-subtitle { font-size: 0.85rem; color: var(--color-ink-muted); text-align: center; margin-bottom: var(--space-md); }
.chart-grid { display: grid; grid-template-columns: 1fr 1fr; gap: var(--space-lg); margin: var(--space-xl) 0; }
@media (max-width: 768px) { .chart-grid { grid-template-columns: 1fr; } }
.chart-source { font-size: 0.75rem; color: var(--color-ink-muted); margin-top: var(--space-sm); text-align: right; font-style: italic; }
.debt-slider-container { margin: var(--space-lg) 0; padding: var(--space-lg); background: var(--color-surface-alt); border-radius: var(--radius-md); }
.debt-slider-container label { font-family: var(--font-body); font-weight: 600; font-size: 0.9rem; color: var(--color-ink); }
.debt-slider-container input[type="range"] { width: 100%; margin: var(--space-sm) 0; accent-color: var(--color-accent); }
.debt-result { font-family: var(--font-display); font-size: 1.5rem; font-weight: 700; color: var(--color-accent); text-align: center; margin-top: var(--space-md); }
.debt-result-sub { font-size: 0.9rem; color: var(--color-ink-muted); text-align: center; }
CHARTCSS

# ============================================================
# FEDERAL TAXES PAGE (updated with FY2025 data + charts)
# ============================================================
cat > federal-taxes.html << 'PAGEEOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/style.css">
<link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>◆</text></svg>">
<title>Individual Federal Income Tax — Chris Crossett</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.7/chart.umd.min.js"></script>
</head>
<body>
<nav class="nav"><div class="nav-inner"><a href="index.html" class="nav-brand">Chris <span>Crossett</span></a><button class="nav-toggle" aria-label="Menu"><span></span><span></span><span></span></button><ul class="nav-links"><li class="nav-dropdown"><a href="#" class="nav-dropdown-trigger">Government</a><div class="nav-dropdown-menu"><a href="federal-reform.html">Federal Reform Overview</a><a href="federal-taxes.html">Federal Taxes</a><a href="national-sales-tax.html">National Sales Tax</a><a href="federal-spending.html">Federal Spending</a><a href="non-financial-changes.html">Non-Financial Reforms</a><a href="privatization.html">Privatization</a><a href="state-govt.html">State Government</a><a href="county-govt.html">County Government</a><a href="local-govt.html">Local Government</a></div></li><li class="nav-dropdown"><a href="#" class="nav-dropdown-trigger">Finance</a><div class="nav-dropdown-menu"><a href="mortgages.html">Mortgage Reform</a><a href="real-estate.html">Real Estate</a><a href="daily-finance.html">Daily Finance</a></div></li><li><a href="about.html">About</a></li><li><a href="contact.html">Contact</a></li></ul></div></nav>

<section class="page-hero"><div class="container">
<div class="breadcrumb"><a href="index.html">Home</a> <span>›</span> <a href="federal-reform.html">Government</a> <span>›</span> Federal Taxes</div>
<div class="hero-eyebrow animate-in">Tax Reform</div>
<h1 class="animate-in delay-1">Individual Federal Income Tax</h1>
<p class="animate-in delay-2">Replacing all federal taxes with a simplified system that eliminates fraud and reduces overhead.</p>
</div></section>

<section class="article"><div class="container"><div class="article-content">

<div class="stat-row">
  <div class="stat-item"><div class="number">$5.23T</div><div class="desc">FY2025 Total Federal Revenue</div></div>
  <div class="stat-item"><div class="number">$2.66T</div><div class="desc">Individual Income Tax</div></div>
  <div class="stat-item"><div class="number">$1.75T</div><div class="desc">Social Insurance / Payroll</div></div>
</div>

<!-- Current Revenue Breakdown Chart -->
<div class="chart-container">
  <div class="chart-title">Current Federal Revenue Breakdown (FY2025)</div>
  <div class="chart-subtitle">Total: $5.23 Trillion — Source: U.S. Treasury</div>
  <canvas id="revenueDonut"></canvas>
  <div class="chart-source">Data: U.S. Treasury Combined Statement FY2025</div>
</div>

<h2>The Problem: A Complex, Costly Tax System</h2>
<p>The current federal tax code runs tens of thousands of pages. It requires individuals and businesses to spend billions of hours and dollars on compliance. The IRS employs tens of thousands of workers to enforce it. And despite all of this complexity, fraud and misconduct persist.</p>

<div class="concept-block"><div class="label">Proposed Solution</div><div class="value">Replace the entire tax code with a 5% National Sales Tax + 5% Corporate Tax on Net Sales</div></div>

<!-- Current vs Proposed Chart -->
<div class="chart-container">
  <div class="chart-title">Current System vs. Proposed System</div>
  <div class="chart-subtitle">Simplification from 6 tax categories to 2</div>
  <canvas id="comparisonBar"></canvas>
</div>

<hr>

<h2>Individual Income Tax → National Sales Tax</h2>
<div class="stat-row">
  <div class="stat-item"><div class="number">$2.66T</div><div class="desc">Current: Individual Income Tax</div></div>
  <div class="stat-item"><div class="number">50.7%</div><div class="desc">Share of Federal Revenue</div></div>
  <div class="stat-item"><div class="number">5%</div><div class="desc">Proposed National Sales Tax</div></div>
</div>
<ul>
  <li>Tax to be levied on all new purchases (items where tax has not been previously levied)</li>
  <li>No more filing individual income taxes</li>
  <li>Easier for employers to pay individuals (not having to calculate income tax)</li>
  <li>IRS not needed for tax compliance — massive administrative savings</li>
  <li><strong>Exempt all Groceries</strong> (Food &amp; Beverages) to protect families</li>
</ul>

<hr>

<h2>Payroll Taxes → Eliminated</h2>
<div class="stat-row">
  <div class="stat-item"><div class="number">$1.75T</div><div class="desc">Current: Social Insurance Taxes</div></div>
  <div class="stat-item"><div class="number">33.4%</div><div class="desc">Share of Federal Revenue</div></div>
  <div class="stat-item"><div class="number">$0</div><div class="desc">Proposed: Eliminated</div></div>
</div>
<ul>
  <li>Social Security to be considered part of debt and paid with 5% of National Sales Tax</li>
  <li>Federal Government to refund all prior contributions into a General Retirement Account</li>
  <li>Priority given to those already in or near retirement</li>
</ul>

<hr>

<h2>Excise Taxes → Eliminated</h2>
<div class="stat-row">
  <div class="stat-item"><div class="number">$106B</div><div class="desc">Current: Excise Taxes</div></div>
  <div class="stat-item"><div class="number">2.0%</div><div class="desc">Share of Federal Revenue</div></div>
</div>
<p>Eliminate all excise taxes. The states are closer to assess the needs of their state as it relates to Gas, Alcohol, Tobacco, and Airports.</p>

<hr>

<h2>Corporate Taxes → 5% of Net Sales</h2>
<div class="stat-row">
  <div class="stat-item"><div class="number">$452B</div><div class="desc">Current: Corporate Income Tax</div></div>
  <div class="stat-item"><div class="number">5%</div><div class="desc">Proposed Rate on Net Sales</div></div>
</div>
<p>Set the Corporate Tax to 5.0% of Net Sales (Gross Sales less Returns and Allowances). Changing the corporate tax to be based on net revenue significantly reduces the overhead and complexity of corporate tax.</p>

<hr>

<p><strong>These plans eliminate the entire current tax code and replace it with a very simple tax system. It also takes out, for the most part, the ability for fraud and misconduct.</strong></p>

<div class="post-nav">
  <a href="federal-reform.html"><div class="post-nav-label">← Previous</div><div class="post-nav-title">Federal Reform Overview</div></a>
  <a href="national-sales-tax.html"><div class="post-nav-label">Next →</div><div class="post-nav-title">National Sales Tax</div></a>
</div>

</div></div></section>

<footer class="footer"><div class="footer-inner"><div><div class="footer-brand">Chris Crossett</div><p>Ideas for major societal leaps forward.</p></div><ul class="footer-links"><li><a href="about.html">About</a></li><li><a href="contact.html">Contact</a></li><li><a href="federal-reform.html">Government</a></li><li><a href="mortgages.html">Finance</a></li></ul></div></footer>
<script src="js/main.js"></script>
<script>
// Color palette
const colors = {
  navy: '#0e3348', blue: '#1a5276', teal: '#148f77', gold: '#b8860b',
  red: '#c0392b', gray: '#6e7681', lightBlue: '#5dade2', green: '#27ae60',
  orange: '#e67e22', purple: '#8e44ad'
};

// Revenue Donut
new Chart(document.getElementById('revenueDonut'), {
  type: 'doughnut',
  data: {
    labels: ['Individual Income Tax — $2,656B', 'Social Insurance / Payroll — $1,748B', 'Corporate Income Tax — $452B', 'Customs Duties — $195B', 'Excise Taxes — $106B', 'Estate, Gift & Other — $78B'],
    datasets: [{
      data: [2656, 1748, 452, 195, 106, 78],
      backgroundColor: [colors.navy, colors.blue, colors.gold, colors.teal, colors.orange, colors.gray],
      borderWidth: 2, borderColor: '#fff', hoverOffset: 8
    }]
  },
  options: {
    responsive: true, maintainAspectRatio: true,
    cutout: '55%',
    plugins: {
      legend: { position: 'bottom', labels: { padding: 16, font: { family: "'DM Sans', sans-serif", size: 12 }, usePointStyle: true, pointStyle: 'rectRounded' } },
      tooltip: { callbacks: { label: function(ctx) { return ctx.label + ' (' + (ctx.parsed / 52.35).toFixed(1) + '%)'; } } }
    }
  }
});

// Comparison Bar Chart
new Chart(document.getElementById('comparisonBar'), {
  type: 'bar',
  data: {
    labels: ['Individual Income', 'Payroll / Social Ins.', 'Corporate Income', 'Excise', 'Customs & Other', 'National Sales Tax (5%)'],
    datasets: [
      { label: 'Current System ($B)', data: [2656, 1748, 452, 106, 273, 0], backgroundColor: colors.navy, borderRadius: 4 },
      { label: 'Proposed System ($B)', data: [0, 0, 0, 0, 0, 1900], backgroundColor: colors.gold, borderRadius: 4 }
    ]
  },
  options: {
    responsive: true, maintainAspectRatio: true,
    indexAxis: 'y',
    plugins: {
      legend: { position: 'top', labels: { font: { family: "'DM Sans', sans-serif", size: 12 }, usePointStyle: true, pointStyle: 'rectRounded', padding: 16 } },
      tooltip: { callbacks: { label: function(ctx) { return ctx.dataset.label + ': $' + ctx.parsed.x + 'B'; } } }
    },
    scales: {
      x: { title: { display: true, text: 'Billions ($)', font: { family: "'DM Sans', sans-serif" } }, grid: { color: '#e8e5e0' } },
      y: { grid: { display: false }, ticks: { font: { family: "'DM Sans', sans-serif", size: 11 } } }
    }
  }
});
</script>
</body>
</html>
PAGEEOF

# ============================================================
# FEDERAL SPENDING PAGE (updated with charts + debt projection)
# ============================================================
cat > federal-spending.html << 'PAGEEOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/style.css">
<link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>◆</text></svg>">
<title>Federal Government Spending — Chris Crossett</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.7/chart.umd.min.js"></script>
</head>
<body>
<nav class="nav"><div class="nav-inner"><a href="index.html" class="nav-brand">Chris <span>Crossett</span></a><button class="nav-toggle" aria-label="Menu"><span></span><span></span><span></span></button><ul class="nav-links"><li class="nav-dropdown"><a href="#" class="nav-dropdown-trigger">Government</a><div class="nav-dropdown-menu"><a href="federal-reform.html">Federal Reform Overview</a><a href="federal-taxes.html">Federal Taxes</a><a href="national-sales-tax.html">National Sales Tax</a><a href="federal-spending.html">Federal Spending</a><a href="non-financial-changes.html">Non-Financial Reforms</a><a href="privatization.html">Privatization</a><a href="state-govt.html">State Government</a><a href="county-govt.html">County Government</a><a href="local-govt.html">Local Government</a></div></li><li class="nav-dropdown"><a href="#" class="nav-dropdown-trigger">Finance</a><div class="nav-dropdown-menu"><a href="mortgages.html">Mortgage Reform</a><a href="real-estate.html">Real Estate</a><a href="daily-finance.html">Daily Finance</a></div></li><li><a href="about.html">About</a></li><li><a href="contact.html">Contact</a></li></ul></div></nav>

<section class="page-hero"><div class="container">
<div class="breadcrumb"><a href="index.html">Home</a> <span>›</span> <a href="federal-reform.html">Government</a> <span>›</span> Federal Spending</div>
<div class="hero-eyebrow animate-in">Budgeting &amp; Spending</div>
<h1 class="animate-in delay-1">Federal Government Spending</h1>
<p class="animate-in delay-2">Creating a balanced budget and sunsetting unsustainable social programs.</p>
</div></section>

<section class="article"><div class="container"><div class="article-content">

<div class="stat-row">
  <div class="stat-item"><div class="number">$7.1T</div><div class="desc">FY2025 Total Spending</div></div>
  <div class="stat-item"><div class="number">$1.78T</div><div class="desc">FY2025 Deficit</div></div>
  <div class="stat-item"><div class="number">$39T</div><div class="desc">National Debt (Mar 2026)</div></div>
</div>

<p>The US Federal Government spent $7.1 trillion in FY2025 while collecting only $5.3 trillion in revenue — a deficit of $1.78 trillion added to a national debt that now exceeds $39 trillion. Interest payments alone consumed $962 billion, or 14% of all spending. This is unsustainable.</p>

<!-- Current Spending Chart -->
<div class="chart-container">
  <div class="chart-title">Where Federal Dollars Go (FY2025)</div>
  <div class="chart-subtitle">Total Spending: $7.1 Trillion</div>
  <canvas id="spendingDonut"></canvas>
  <div class="chart-source">Data: USAFacts / Office of Management and Budget, FY2025</div>
</div>

<h2>Budget Allocation: 10% National Sales Tax</h2>
<div class="concept-block"><div class="label">Core Principle</div><div class="value">Cap total federal outlays to taxes collected — no additional debt. Ever.</div></div>

<p>Under this plan, the 10% National Sales Tax would generate approximately $1.9 trillion annually. That revenue would be allocated as follows:</p>

<!-- Proposed Allocation Chart -->
<div class="chart-container">
  <div class="chart-title">Proposed Budget Allocation</div>
  <div class="chart-subtitle">10% National Sales Tax Revenue (~$1.9T) + 5% Corporate Tax (~$450B)</div>
  <canvas id="allocationDonut"></canvas>
</div>

<table>
  <thead><tr><th>Allocation</th><th>Rate</th><th>Est. Annual $</th><th>Purpose</th></tr></thead>
  <tbody>
    <tr><td>National Debt</td><td>2%</td><td>~$380B</td><td>Pay down existing national debt</td></tr>
    <tr><td>Social Security Debt</td><td>2%</td><td>~$380B</td><td>Repayments to individuals</td></tr>
    <tr><td>Medicare Debt</td><td>1%</td><td>~$190B</td><td>Repayments to individuals</td></tr>
    <tr><td>Defense &amp; Related</td><td>4%</td><td>~$760B</td><td>As directed by the Constitution</td></tr>
    <tr><td>Other / Non-Defense</td><td>1%</td><td>~$190B</td><td>All remaining federal functions</td></tr>
    <tr><td><strong>Total</strong></td><td><strong>10%</strong></td><td><strong>~$1,900B</strong></td><td></td></tr>
  </tbody>
</table>

<p>Once all debts are paid off (National Debt, Social Security, Medicare), we reduce the National Sales Tax to 5%. One suggestion: accrue one year's worth of funds (at 5%) for the following year's budget.</p>

<hr>

<!-- DEBT PAYOFF TIMELINE -->
<h2>National Debt Payoff Timeline</h2>
<p>Under this plan, 50% of revenue is dedicated to debt repayment. The interactive chart below projects how long it would take to pay off the national debt based on different annual repayment levels.</p>

<div class="debt-slider-container">
  <label>Annual Debt Repayment: <strong id="repaymentLabel">$950B</strong></label>
  <input type="range" id="repaymentSlider" min="500" max="1500" value="950" step="50">
  <div style="display:flex;justify-content:space-between;font-size:0.75rem;color:var(--color-ink-muted);"><span>$500B/yr</span><span>$1,000B/yr</span><span>$1,500B/yr</span></div>
  <div class="debt-result" id="payoffResult">~41 years to pay off</div>
  <div class="debt-result-sub" id="payoffYear">Debt-free by approximately 2067</div>
</div>

<div class="chart-container">
  <div class="chart-title">Projected National Debt Payoff</div>
  <div class="chart-subtitle">Starting from $39T (March 2026) — assumes 3.4% avg interest rate</div>
  <canvas id="debtTimeline"></canvas>
  <div class="chart-source">Projection model based on current Treasury data. Interest rate: avg 3.4%</div>
</div>

<hr>

<h2>Social Programs Reform</h2>
<p>Our government spends more money than it brings in, and the money contributed by individuals and employers into Social Security, Medicare, and Medicaid has already been spent. The reform is simple: sunset each program by paying back the amount contributed.</p>

<h3>How to Sunset Social Security</h3>
<ul>
  <li>Provide 18 months notice</li>
  <li>End employment of all SSA workers; end employee/employer contributions</li>
  <li>For those currently collecting: determine total contributions vs. payments made, fund an IRA with the Net Balance</li>
  <li>For those not yet receiving: fund IRA starting with those closest to retirement</li>
  <li>Create a <strong>Personal Social Security Ledger</strong> (Lifetime Contribution Audit) for every worker</li>
</ul>

<h3>How to Sunset Medicare</h3>
<ul>
  <li>Provide 18 months notice</li>
  <li>End all administration employment and contributions</li>
  <li>Fund a Health Savings Account (HSA) with each individual's Net Balance</li>
</ul>

<h3>How to Sunset Medicaid &amp; Federal Unemployment</h3>
<p>Provide 18 month notice and end in entirety.</p>

<div class="post-nav">
  <a href="national-sales-tax.html"><div class="post-nav-label">← Previous</div><div class="post-nav-title">National Sales Tax</div></a>
  <a href="non-financial-changes.html"><div class="post-nav-label">Next →</div><div class="post-nav-title">Non-Financial Changes</div></a>
</div>

</div></div></section>

<footer class="footer"><div class="footer-inner"><div><div class="footer-brand">Chris Crossett</div><p>Ideas for major societal leaps forward.</p></div><ul class="footer-links"><li><a href="about.html">About</a></li><li><a href="contact.html">Contact</a></li><li><a href="federal-reform.html">Government</a></li><li><a href="mortgages.html">Finance</a></li></ul></div></footer>
<script src="js/main.js"></script>
<script>
const colors = {
  navy: '#0e3348', blue: '#1a5276', teal: '#148f77', gold: '#b8860b',
  red: '#c0392b', gray: '#6e7681', lightBlue: '#5dade2', green: '#27ae60',
  orange: '#e67e22', purple: '#8e44ad'
};

// Spending Donut
new Chart(document.getElementById('spendingDonut'), {
  type: 'doughnut',
  data: {
    labels: ['Social Security — $1,461B', 'National Defense — $874B', 'Net Interest — $962B', 'Medicare — $869B', 'Health (Medicaid etc.) — $889B', 'Income Security — $671B', 'Veterans — $351B', 'Other — $1,023B'],
    datasets: [{
      data: [1461, 874, 962, 869, 889, 671, 351, 1023],
      backgroundColor: [colors.navy, colors.blue, colors.red, colors.teal, colors.green, colors.gold, colors.purple, colors.gray],
      borderWidth: 2, borderColor: '#fff', hoverOffset: 8
    }]
  },
  options: {
    responsive: true, cutout: '55%',
    plugins: {
      legend: { position: 'bottom', labels: { padding: 14, font: { family: "'DM Sans', sans-serif", size: 11 }, usePointStyle: true, pointStyle: 'rectRounded' } },
      tooltip: { callbacks: { label: function(ctx) { return ctx.label + ' (' + (ctx.parsed / 71).toFixed(1) + '%)'; } } }
    }
  }
});

// Proposed Allocation Donut
new Chart(document.getElementById('allocationDonut'), {
  type: 'doughnut',
  data: {
    labels: ['Defense & Related (4%) — $760B', 'National Debt Repayment (2%) — $380B', 'Social Security Repayment (2%) — $380B', 'Medicare Repayment (1%) — $190B', 'Other / Non-Defense (1%) — $190B'],
    datasets: [{
      data: [760, 380, 380, 190, 190],
      backgroundColor: [colors.blue, colors.red, colors.navy, colors.teal, colors.gray],
      borderWidth: 2, borderColor: '#fff', hoverOffset: 8
    }]
  },
  options: {
    responsive: true, cutout: '55%',
    plugins: {
      legend: { position: 'bottom', labels: { padding: 14, font: { family: "'DM Sans', sans-serif", size: 12 }, usePointStyle: true, pointStyle: 'rectRounded' } }
    }
  }
});

// Debt Payoff Timeline
function calculateDebt(annualPayment) {
  const startDebt = 39000; // $39T in billions
  const interestRate = 0.034;
  const years = [];
  const debts = [];
  let debt = startDebt;
  let year = 2026;
  while (debt > 0 && year <= 2100) {
    years.push(year);
    debts.push(Math.max(0, debt / 1000)); // convert to trillions
    const interest = debt * interestRate;
    debt = debt + interest - annualPayment;
    year++;
  }
  if (debt <= 0) { years.push(year); debts.push(0); }
  return { years, debts, payoffYear: debt <= 0 ? year : null };
}

let debtChart;
function updateDebtChart(annualPayment) {
  const result = calculateDebt(annualPayment);
  document.getElementById('repaymentLabel').textContent = '$' + annualPayment + 'B';
  if (result.payoffYear) {
    const yearsToPayoff = result.payoffYear - 2026;
    document.getElementById('payoffResult').textContent = '~' + yearsToPayoff + ' years to pay off';
    document.getElementById('payoffYear').textContent = 'Debt-free by approximately ' + result.payoffYear;
  } else {
    document.getElementById('payoffResult').textContent = 'Debt continues to grow';
    document.getElementById('payoffYear').textContent = 'Annual payment does not exceed interest — increase repayment';
  }
  if (debtChart) {
    debtChart.data.labels = result.years;
    debtChart.data.datasets[0].data = result.debts;
    debtChart.update();
  } else {
    debtChart = new Chart(document.getElementById('debtTimeline'), {
      type: 'line',
      data: {
        labels: result.years,
        datasets: [{
          label: 'National Debt ($T)',
          data: result.debts,
          borderColor: colors.navy,
          backgroundColor: 'rgba(14,51,72,0.08)',
          fill: true, tension: 0.3, pointRadius: 0, borderWidth: 3
        }]
      },
      options: {
        responsive: true,
        plugins: {
          legend: { display: false },
          tooltip: { callbacks: { label: function(ctx) { return '$' + ctx.parsed.y.toFixed(1) + ' Trillion'; } } }
        },
        scales: {
          x: { grid: { color: '#e8e5e0' }, ticks: { font: { family: "'DM Sans', sans-serif", size: 11 }, maxTicksLimit: 12 } },
          y: { title: { display: true, text: 'Debt ($ Trillions)', font: { family: "'DM Sans', sans-serif" } }, grid: { color: '#e8e5e0' }, beginAtZero: true }
        }
      }
    });
  }
}

// Initialize
updateDebtChart(950);
document.getElementById('repaymentSlider').addEventListener('input', function() { updateDebtChart(parseInt(this.value)); });
</script>
</body>
</html>
PAGEEOF

echo ""
echo "✅ Update complete!"
echo "   - federal-taxes.html: Updated with FY2025 data + revenue donut chart + comparison bar chart"
echo "   - federal-spending.html: Updated with FY2025 data + spending donut + allocation donut + interactive debt payoff timeline"
echo "   - css/style.css: Added chart container styles"
echo ""
echo "Refresh your browser to see the changes!"
