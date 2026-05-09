const nav = document.querySelector('.nav');
window.addEventListener('scroll', () => { nav?.classList.toggle('scrolled', window.scrollY > 20); });
const toggle = document.querySelector('.nav-toggle');
const links = document.querySelector('.nav-links');
toggle?.addEventListener('click', () => { links?.classList.toggle('open'); });
document.querySelectorAll('.nav-dropdown-trigger').forEach(trigger => {
  trigger.setAttribute('aria-expanded', 'false');
  trigger.addEventListener('click', (e) => {
    e.preventDefault();
    if (window.innerWidth <= 900) {
      const dd = trigger.closest('.nav-dropdown');
      const open = dd?.classList.toggle('open');
      trigger.setAttribute('aria-expanded', open ? 'true' : 'false');
    }
  });
});
document.addEventListener('click', (e) => {
  if (window.innerWidth > 900) return;
  document.querySelectorAll('.nav-dropdown.open').forEach(dd => {
    if (!dd.contains(e.target)) {
      dd.classList.remove('open');
      dd.querySelector('.nav-dropdown-trigger')?.setAttribute('aria-expanded', 'false');
    }
  });
});
document.querySelectorAll('.nav-links a:not(.nav-dropdown-trigger)').forEach(link => { link.addEventListener('click', () => { links?.classList.remove('open'); }); });
const observer = new IntersectionObserver((entries) => { entries.forEach(entry => { if (entry.isIntersecting) { entry.target.classList.add('animate-in'); observer.unobserve(entry.target); } }); }, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' });
document.querySelectorAll('.observe').forEach(el => observer.observe(el));
const currentPath = window.location.pathname.replace(/\/$/, '').split('/').pop() || 'index';
document.querySelectorAll('.nav-links a, .sidebar-nav a').forEach(link => { const href = link.getAttribute('href')?.replace(/\/$/, '').split('/').pop()?.replace('.html', '') || ''; if (href === currentPath || (href === 'index' && currentPath === '')) { link.classList.add('active'); } });
