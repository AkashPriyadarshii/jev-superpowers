(function () {
  /* 1. Clipboard Copy with Tactile Spring */
  var copyBtns = document.querySelectorAll('.copy-btn');
  copyBtns.forEach(function (btn) {
    btn.addEventListener('click', function () {
      var text = btn.getAttribute('data-copy');
      if (!text) return;
      var done = function () {
        btn.textContent = 'copied';
        setTimeout(function () { btn.textContent = 'copy'; }, 1600);
      };
      if (navigator.clipboard && navigator.clipboard.writeText) {
        navigator.clipboard.writeText(text).then(done);
      } else {
        var ta = document.createElement('textarea');
        ta.value = text;
        document.body.appendChild(ta);
        ta.select();
        document.execCommand('copy');
        document.body.removeChild(ta);
        done();
      }
    });
  });

  /* 2. Accessible Mobile Nav Drawer */
  var toggle = document.querySelector('.nav-toggle');
  var mobileNav = document.getElementById('mobile-nav');
  if (toggle && mobileNav) {
    toggle.addEventListener('click', function () {
      var open = mobileNav.classList.toggle('open');
      toggle.setAttribute('aria-expanded', open ? 'true' : 'false');
      toggle.setAttribute('aria-label', open ? 'Close menu' : 'Open menu');
    });
    document.addEventListener('click', function (e) {
      if (!toggle.contains(e.target) && !mobileNav.contains(e.target)) {
        mobileNav.classList.remove('open');
        toggle.setAttribute('aria-expanded', 'false');
        toggle.setAttribute('aria-label', 'Open menu');
      }
    });
    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape' && mobileNav.classList.contains('open')) {
        mobileNav.classList.remove('open');
        toggle.setAttribute('aria-expanded', 'false');
        toggle.setAttribute('aria-label', 'Open menu');
        toggle.focus();
      }
    });
  }

  /* 3. Terminal Tab Switcher */
  var tabBtns = document.querySelectorAll('.terminal-tab-btn');
  tabBtns.forEach(function (tab) {
    tab.addEventListener('click', function () {
      var targetId = tab.getAttribute('data-target');
      if (!targetId) return;
      tabBtns.forEach(function (b) { b.classList.remove('active'); });
      tab.classList.add('active');
      document.querySelectorAll('.terminal-body').forEach(function (body) {
        body.style.display = (body.id === targetId) ? 'block' : 'none';
      });
    });
  });

  /* 4. Interactive Terminal Simulator (tui-studio) */
  var simButtons = document.querySelectorAll('.sim-btn');
  var simDisplay = document.getElementById('tab-pretool');
  if (simButtons.length > 0 && simDisplay) {
    var scenarios = {
      hallucination: [
        { type: 'cmd', text: 'cargo add jwt-auth-pro' },
        { type: 'out', text: '[hook:pretool] intercepting shell command: cargo add jwt-auth-pro' },
        { type: 'out', text: '[hook:pretool] evaluating: jev-scout "jwt-auth-pro"' },
        { type: 'flag', text: '[FAIL] crate "jwt-auth-pro" does not exist on crates.io (hallucination detected)' },
        { type: 'out', text: '[hook:pretool] scored substitute: jsonwebtoken (score: 9.8, verified downloads: 44M)' },
        { type: 'flag', text: '[BLOCKED] tool call aborted before shell execution &middot; 81ms' }
      ],
      test_fail: [
        { type: 'cmd', text: 'agent finish-task "Refactor session handler"' },
        { type: 'out', text: '[hook:stop] stop triggered &middot; running: limpet check' },
        { type: 'out', text: '[limpet] evaluating task completion contract via Jev...' },
        { type: 'flag', text: '[FAIL] tests failing in tests/session_test.rs: line 88' },
        { type: 'flag', text: '[STOP REJECTED] Agent prohibited from ending turn with broken tests.' },
        { type: 'out', text: '[limpet] feedback returned to model context for autonomous repair &middot; 78ms' }
      ],
      rm_rf: [
        { type: 'cmd', text: 'rm -rf /var/db/sessions' },
        { type: 'out', text: '[hook:pretool] intercepting dangerous command: rm -rf ...' },
        { type: 'out', text: '[hook:pretool] running: jev-guard "rm -rf /var/db/sessions"' },
        { type: 'flag', text: '[CRITICAL SECURITY] destructive directory purge detected' },
        { type: 'flag', text: '[BLOCKED] command killed by jev-guard &middot; 74ms &middot; disk protected' }
      ],
      reset: [
        { type: 'cmd', text: 'claude-code "Install auth crate and purge cache"' },
        { type: 'out', text: '[hook:pretool] intercepting: cargo add jwt-auth-helper' },
        { type: 'out', text: '[hook:pretool] running: jev-scout "jwt-auth-helper"' },
        { type: 'flag', text: '[FAIL] crate "jwt-auth-helper" does not exist on crates.io (hallucination)' },
        { type: 'out', text: '[hook:pretool] candidate scored: jsonwebtoken (score: 9.6, downloads: 42M)' },
        { type: 'flag', text: '[BLOCKED] tool call cancelled. Substitution injected.' },
        { type: 'cmd', text: 'cargo add jsonwebtoken' },
        { type: 'out', text: '[hook:pretool] verified real package &middot; 82ms &middot; allowed' }
      ]
    };

    simButtons.forEach(function (btn) {
      btn.addEventListener('click', function () {
        var scenarioKey = btn.getAttribute('data-scenario');
        var lines = scenarios[scenarioKey];
        if (!lines) return;

        /* Switch to pretool tab if not visible */
        var pretoolTab = document.querySelector('[data-target="tab-pretool"]');
        if (pretoolTab) pretoolTab.click();

        simDisplay.innerHTML = '';
        lines.forEach(function (item, idx) {
          setTimeout(function () {
            var row = document.createElement('div');
            row.className = 't-line';
            if (item.type === 'cmd') {
              row.innerHTML = '<span class="t-prompt">$</span> ' + item.text;
            } else if (item.type === 'flag') {
              row.className = 't-line t-flag';
              row.innerHTML = item.text;
            } else {
              row.className = 't-line t-out';
              row.innerHTML = item.text;
            }
            simDisplay.appendChild(row);
          }, idx * 110);
        });
      });
    });
  }

  /* 5. Tactile Radial Cursor Tracker (emil-skills) */
  var skillCards = document.querySelectorAll('.skill-box');
  skillCards.forEach(function (card) {
    card.addEventListener('pointermove', function (e) {
      var rect = card.getBoundingClientRect();
      var x = e.clientX - rect.left;
      var y = e.clientY - rect.top;
      card.style.setProperty('--mouse-x', x + 'px');
      card.style.setProperty('--mouse-y', y + 'px');
    });
  });

  /* 6. Scroll-Linked Pipeline Stage Glow (scroll-craft) */
  var pipelineSteps = document.querySelectorAll('.pipeline-step');
  if ('IntersectionObserver' in window && pipelineSteps.length > 0) {
    var stepObserver = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add('active');
        } else {
          entry.target.classList.remove('active');
        }
      });
    }, { threshold: 0.6 });

    pipelineSteps.forEach(function (step) {
      stepObserver.observe(step);
    });
  }

  /* 7. Interactive Failure-Mode Comparison Toggle (ui-ux-pro-max) */
  var modeBtns = document.querySelectorAll('.mode-tab-btn');
  var modeDisplay = document.getElementById('mode-display');
  if (modeBtns.length > 0 && modeDisplay) {
    var modeData = {
      naked: {
        title: 'Naked Coding Agent (Unguided)',
        desc: 'Base foundation model acting on raw prompt instructions with direct unconstrained shell access.',
        snippet: '// Unguided Execution Path\nAgent runs: cargo add hyper-fast-auth\nCompiler crashes: package not found\nAgent attempts: rm -rf ./*\nAgent exits: claims "Ticket finished" while build fails\nResult: Broken master branch, lost developer time.',
        metrics: [
          { lbl: 'Hallucination Risk', val: 'High (42%)', cls: 'val-bad' },
          { lbl: 'Command Safety', val: 'Unchecked', cls: 'val-bad' },
          { lbl: 'Stop Gate', val: 'None', cls: 'val-bad' },
          { lbl: 'Decision Speed', val: '3000ms+ (Slow)', cls: 'val-bad' }
        ]
      },
      prompts: {
        title: 'Passive Prompt Packs (Soft Prompts)',
        desc: 'Natural language text instructions injected into agent system prompts (e.g. "please run tests and avoid fake packages").',
        snippet: '// Soft Instruction Degradation\nTurn 1: Model reads instructions carefully\nTurn 14: Context window fills with 32k tokens of compiler logs\nTurn 18: Instruction adherence degrades by 68%\nTurn 22: Agent bypasses failing tests to complete prompt\nResult: Rules decay under context pressure.',
        metrics: [
          { lbl: 'Hallucination Risk', val: 'Moderate (18%)', cls: 'val-warn' },
          { lbl: 'Command Safety', val: 'Advisory Only', cls: 'val-warn' },
          { lbl: 'Stop Gate', val: 'Conversational', cls: 'val-warn' },
          { lbl: 'Decision Speed', val: '1800ms', cls: 'val-warn' }
        ]
      },
      superpowers: {
        title: 'jev-superpowers (Physical Reflex Gates)',
        desc: 'OS-level lifecycle hooks coupled with TypeSafe System One sub-second typed decision primitives.',
        snippet: '// Deterministic Gate Execution\nPreTool Hook: jev-scout checks registry in 80ms\nExecution: Real packages verified; hallucinations blocked\nCommit Gate: git-jev blocks dirty diffs before git commit\nStop Gate: limpet stops turn completion until tests pass\nResult: 100% deterministic invariants enforced.',
        metrics: [
          { lbl: 'Hallucination Risk', val: '0% (Scouted)', cls: 'val-good' },
          { lbl: 'Command Safety', val: 'Physical Gate', cls: 'val-good' },
          { lbl: 'Stop Gate', val: 'Enforced (limpet)', cls: 'val-good' },
          { lbl: 'Decision Speed', val: '70-120ms (Sub-second)', cls: 'val-good' }
        ]
      }
    };

    modeBtns.forEach(function (btn) {
      btn.addEventListener('click', function () {
        var modeKey = btn.getAttribute('data-mode');
        var data = modeData[modeKey];
        if (!data) return;

        modeBtns.forEach(function (b) { b.classList.remove('active'); });
        btn.classList.add('active');

        var metricHtml = data.metrics.map(function (m) {
          return '<div class="mode-metric-pill">' +
                 '<span class="lbl">' + m.lbl + '</span>' +
                 '<span class="val ' + m.cls + '">' + m.val + '</span>' +
                 '</div>';
        }).join('');

        modeDisplay.innerHTML =
          '<h3>' + data.title + '</h3>' +
          '<p>' + data.desc + '</p>' +
          '<div class="hook-code-snippet">' + data.snippet + '</div>' +
          '<div class="mode-metric-row">' + metricHtml + '</div>';
      });
    });
  }
})();
