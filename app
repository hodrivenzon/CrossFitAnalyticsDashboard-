<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FORGE — CrossFit Strength Analytics</title>
<style>
  :root{
    --bg:#0b0e14; --bg2:#11151f; --card:#161b27; --card2:#1c2230;
    --line:#252c3d; --txt:#e6ebf5; --mut:#8b95a8; --dim:#5d6678;
    --accent:#ff5a3c; --accent2:#ffb83c; --good:#39d98a; --warn:#ffb83c; --bad:#ff5a5a;
    --blue:#4d9fff; --purple:#a87bff; --teal:#2dd4bf;
    --grad:linear-gradient(135deg,#ff5a3c,#ffb83c);
  }
  *{box-sizing:border-box;margin:0;padding:0}
  body{
    font-family:'Segoe UI',system-ui,-apple-system,sans-serif;
    background:radial-gradient(1200px 600px at 80% -10%,#1a2030 0%,var(--bg) 55%);
    color:var(--txt); line-height:1.45; min-height:100vh; padding-bottom:60px;
  }
  .wrap{max-width:1280px;margin:0 auto;padding:0 20px}
  header{
    display:flex;align-items:center;justify-content:space-between;
    padding:26px 0 20px;flex-wrap:wrap;gap:16px;
  }
  .brand{display:flex;align-items:center;gap:14px}
  .logo{
    width:46px;height:46px;border-radius:12px;background:var(--grad);
    display:grid;place-items:center;font-weight:900;font-size:22px;color:#0b0e14;
    box-shadow:0 8px 24px rgba(255,90,60,.35);
  }
  .brand h1{font-size:22px;letter-spacing:1px;font-weight:800}
  .brand p{color:var(--mut);font-size:12.5px;letter-spacing:.5px}
  .tagpill{
    font-size:11px;color:var(--accent2);border:1px solid var(--line);
    padding:5px 11px;border-radius:999px;background:var(--card);
  }
  .grid{display:grid;gap:16px}
  .cols-3{grid-template-columns:320px 1fr 360px}
  .cols-2{grid-template-columns:1fr 1fr}
  @media(max-width:1100px){.cols-3{grid-template-columns:1fr}.cols-2{grid-template-columns:1fr}}
  .card{
    background:linear-gradient(180deg,var(--card),var(--bg2));
    border:1px solid var(--line);border-radius:16px;padding:18px;
  }
  .card h2{font-size:13px;text-transform:uppercase;letter-spacing:1.4px;color:var(--mut);margin-bottom:14px;display:flex;align-items:center;gap:8px}
  .card h2 .dot{width:7px;height:7px;border-radius:50%;background:var(--accent)}
  label{display:block;font-size:11.5px;color:var(--mut);margin:10px 0 5px;letter-spacing:.4px;text-transform:uppercase}
  input,select{
    width:100%;background:var(--bg);border:1px solid var(--line);color:var(--txt);
    padding:9px 11px;border-radius:9px;font-size:14px;font-family:inherit;
  }
  input:focus,select:focus{outline:none;border-color:var(--accent)}
  .row2{display:grid;grid-template-columns:1fr 1fr;gap:10px}
  .seg{display:flex;background:var(--bg);border:1px solid var(--line);border-radius:9px;padding:3px;gap:3px}
  .seg button{flex:1;background:transparent;border:none;color:var(--mut);padding:8px;border-radius:7px;cursor:pointer;font-size:13px;font-weight:600}
  .seg button.on{background:var(--grad);color:#0b0e14}
  .liftgrid{display:grid;grid-template-columns:1fr 1fr;gap:10px}

  /* Score hero */
  .hero{display:flex;flex-direction:column;align-items:center;text-align:center;gap:6px;padding:6px 0 4px}
  .ring-wrap{position:relative;width:200px;height:200px}
  .ring-num{position:absolute;inset:0;display:grid;place-items:center;flex-direction:column}
  .ring-num b{font-size:52px;font-weight:900;line-height:1;background:var(--grad);-webkit-background-clip:text;background-clip:text;-webkit-text-fill-color:transparent}
  .ring-num span{display:block;font-size:11px;color:var(--mut);letter-spacing:2px;text-transform:uppercase;margin-top:4px}
  .levelbadge{padding:6px 16px;border-radius:999px;font-weight:800;letter-spacing:1px;font-size:14px;text-transform:uppercase}

  /* Stratification bars */
  .strat{display:flex;flex-direction:column;gap:11px}
  .strat-row{display:grid;grid-template-columns:96px 1fr 56px;align-items:center;gap:10px}
  .strat-row .name{font-size:12.5px;color:var(--txt);font-weight:600}
  .strat-row .name small{display:block;color:var(--dim);font-weight:400;font-size:10px}
  .track{position:relative;height:24px;background:var(--bg);border-radius:7px;overflow:hidden;border:1px solid var(--line)}
  .track .tiers{position:absolute;inset:0;display:flex}
  .track .tiers i{flex:1;border-right:1px solid rgba(255,255,255,.04)}
  .track .fill{position:absolute;top:0;left:0;bottom:0;border-radius:6px 0 0 6px;background:var(--grad);opacity:.85;transition:width .6s cubic-bezier(.2,.8,.2,1)}
  .track .marker{position:absolute;top:-3px;bottom:-3px;width:2px;background:#fff;box-shadow:0 0 8px #fff}
  .strat-row .val{font-size:13px;font-weight:700;text-align:right}
  .strat-row .val small{color:var(--dim);font-weight:400}

  .tierlegend{display:flex;justify-content:space-between;font-size:9.5px;color:var(--dim);letter-spacing:.5px;margin:4px 0 0;padding-left:106px}

  /* radar */
  .radar-wrap{display:flex;justify-content:center}

  /* diagnostics */
  .diag{display:flex;flex-direction:column;gap:10px}
  .alert{display:flex;gap:11px;padding:12px;border-radius:11px;border:1px solid var(--line);background:var(--card2)}
  .alert .ic{width:30px;height:30px;border-radius:8px;flex:0 0 30px;display:grid;place-items:center;font-size:16px}
  .alert.ok .ic{background:rgba(57,217,138,.15)} .alert.ok{border-color:rgba(57,217,138,.3)}
  .alert.warn .ic{background:rgba(255,184,60,.15)} .alert.warn{border-color:rgba(255,184,60,.3)}
  .alert.bad .ic{background:rgba(255,90,90,.15)} .alert.bad{border-color:rgba(255,90,90,.3)}
  .alert b{font-size:13px;display:block;margin-bottom:3px}
  .alert p{font-size:12px;color:var(--mut)}
  .alert .ratio{font-size:11px;color:var(--accent2);font-weight:700;margin-top:4px;display:inline-block}

  /* ratio mini */
  .ratios{display:grid;grid-template-columns:1fr 1fr;gap:11px}
  .ratiocard{background:var(--card2);border:1px solid var(--line);border-radius:11px;padding:12px}
  .ratiocard .lbl{font-size:10.5px;color:var(--mut);text-transform:uppercase;letter-spacing:.6px}
  .ratiocard .big{font-size:26px;font-weight:900;margin:4px 0}
  .ratiocard .sub{font-size:10.5px;color:var(--dim)}
  .ratiocard .bar{height:5px;background:var(--bg);border-radius:3px;margin-top:8px;overflow:hidden}
  .ratiocard .bar i{display:block;height:100%;border-radius:3px}

  /* readiness wheels */
  .wheels{display:grid;grid-template-columns:repeat(3,1fr);gap:14px;margin-top:6px}
  .wheel{text-align:center}
  .wheel .sub{font-size:10.5px;color:var(--mut);text-transform:uppercase;letter-spacing:.6px;margin-top:6px}
  .miniinputs{display:grid;grid-template-columns:1fr 1fr;gap:8px;margin-top:14px}
  .miniinputs label{margin:0 0 3px}

  /* gauge */
  .gauge-wrap{display:flex;flex-direction:column;align-items:center;gap:4px}
  .mrv-status{font-weight:800;letter-spacing:1px;font-size:15px;text-transform:uppercase}
  .mrv-legend{font-size:11px;color:var(--mut);text-align:center;margin-top:2px}

  /* macrocycle */
  .weekstrip{display:grid;grid-template-columns:repeat(9,1fr);gap:5px;margin:10px 0}
  .weekcell{background:var(--bg);border:1px solid var(--line);border-radius:8px;padding:8px 3px;text-align:center;cursor:pointer;transition:.15s}
  .weekcell:hover{border-color:var(--accent)}
  .weekcell.on{background:var(--grad);color:#0b0e14;border-color:transparent}
  .weekcell .wk{font-size:9px;letter-spacing:.5px;opacity:.8}
  .weekcell .pc{font-size:14px;font-weight:800}
  .weekcell .ph{font-size:8px;text-transform:uppercase;opacity:.7;margin-top:2px}
  .targets{display:grid;grid-template-columns:repeat(auto-fill,minmax(120px,1fr));gap:9px;margin-top:8px}
  .tgt{background:var(--card2);border:1px solid var(--line);border-radius:10px;padding:10px}
  .tgt .l{font-size:10.5px;color:var(--mut)}
  .tgt .w{font-size:20px;font-weight:800;color:var(--accent2)}
  .tgt .r{font-size:10px;color:var(--dim)}

  /* percent table */
  .pctctl{display:flex;gap:10px;align-items:flex-end;margin-bottom:12px}
  .pcttable{display:grid;grid-template-columns:repeat(auto-fill,minmax(82px,1fr));gap:7px}
  .pctcell{background:var(--bg);border:1px solid var(--line);border-radius:9px;padding:9px 6px;text-align:center}
  .pctcell .p{font-size:11px;color:var(--mut)}
  .pctcell .k{font-size:17px;font-weight:800}
  .pctcell.hl{border-color:var(--accent);background:rgba(255,90,60,.08)}

  /* compare */
  .cmpbar{display:flex;gap:16px;align-items:center;flex-wrap:wrap}
  .athcard{display:flex;align-items:center;gap:12px;background:var(--card2);border:1px solid var(--line);border-radius:12px;padding:10px 14px;min-width:230px}
  .athav{width:44px;height:44px;border-radius:10px;display:grid;place-items:center;font-size:22px;flex:0 0 44px}
  .athcard b{font-size:14px;display:block}
  .athcard .meta{font-size:11px;color:var(--mut)}
  .athcard .titles{font-size:10px;color:var(--accent2);margin-top:2px}
  .vsgrid{display:grid;grid-template-columns:repeat(auto-fill,minmax(150px,1fr));gap:9px;margin-top:14px}
  .vsrow{background:var(--card2);border:1px solid var(--line);border-radius:10px;padding:9px 11px}
  .vsrow .l{font-size:11px;color:var(--mut)}
  .vsrow .nums{display:flex;align-items:baseline;justify-content:space-between;margin-top:3px}
  .vsrow .you{font-size:16px;font-weight:800}
  .vsrow .them{font-size:13px;font-weight:700;color:var(--blue)}
  .vsrow .delta{font-size:10px;margin-top:2px}
  .vsrow .vbar{height:5px;background:var(--bg);border-radius:3px;margin-top:6px;position:relative;overflow:hidden}
  .vsrow .vbar .yi{position:absolute;left:0;top:0;bottom:0;background:var(--accent);opacity:.8;border-radius:3px}
  .vsrow .vbar .ti{position:absolute;top:-2px;bottom:-2px;width:2px;background:var(--blue);box-shadow:0 0 6px var(--blue)}
  .est{font-size:9px;color:var(--dim);border:1px solid var(--line);border-radius:4px;padding:0 4px;margin-left:4px;vertical-align:middle}
  .leg-dot{display:inline-block;width:9px;height:9px;border-radius:50%;margin-right:5px;vertical-align:middle}
  .foot{color:var(--dim);font-size:11px;text-align:center;margin-top:30px;line-height:1.7}
  .sectitle{font-size:15px;font-weight:800;letter-spacing:.5px;margin:8px 2px 2px;display:flex;align-items:center;gap:9px}
  .sectitle .bar{width:4px;height:18px;background:var(--grad);border-radius:2px}
  .hint{font-size:11px;color:var(--dim);margin-top:3px}
  .spark{display:flex;align-items:flex-end;gap:2px;height:34px;margin-top:4px}
  .spark i{flex:1;background:var(--blue);border-radius:2px 2px 0 0;opacity:.6;min-height:3px}
  .spark i:last-child{background:var(--accent);opacity:1}
  .pill{font-size:10px;padding:3px 9px;border-radius:999px;border:1px solid var(--line);color:var(--mut)}
</style>
</head>
<body>
<div class="wrap">
  <header>
    <div class="brand">
      <div class="logo">⚡</div>
      <div>
        <h1>FORGE<span style="color:var(--accent)">·</span>ANALYTICS</h1>
        <p>Strength Stratification &amp; CrossFit Readiness Engine</p>
      </div>
    </div>
    <div style="display:flex;gap:8px;flex-wrap:wrap">
      <span class="tagpill">2023 Strength Standards</span>
      <span class="tagpill">Adaptation Currency Logic</span>
    </div>
  </header>

  <!-- ===== TOP ROW: profile | stratification | score ===== -->
  <div class="grid cols-3">

    <!-- PROFILE + LIFTS -->
    <div class="card">
      <h2><span class="dot"></span>Athlete Profile</h2>
      <label>Sex</label>
      <div class="seg" id="sexSeg">
        <button data-sex="male" class="on">Male</button>
        <button data-sex="female">Female</button>
      </div>
      <div class="row2">
        <div><label>Bodyweight (kg)</label><input id="bw" type="number" value="80" min="30" max="200"></div>
        <div><label>Age</label><input id="age" type="number" value="28" min="14" max="80"></div>
      </div>

      <h2 style="margin-top:18px"><span class="dot"></span>1RM Lifts (kg)</h2>
      <div class="liftgrid" id="liftGrid"></div>
      <p class="hint">Enter your best lifts. Leave 0 if untested.</p>
    </div>

    <!-- STRATIFICATION MAP -->
    <div class="card">
      <h2><span class="dot"></span>Standard Stratification Map</h2>
      <div class="strat" id="stratList"></div>
      <div class="tierlegend">
        <span>Untrained</span><span>Novice</span><span>Intermediate</span><span>Advanced</span><span>Elite</span>
      </div>
      <p class="hint" style="margin-top:12px">White marker = your lift vs. bodyweight-scaled <span style="color:var(--accent2)">2023 standards</span> for your sex. Fill bar shows position within tier range.</p>
    </div>

    <!-- OVERALL SCORE -->
    <div class="card">
      <h2><span class="dot"></span>Strength Index</h2>
      <div class="hero">
        <div class="ring-wrap">
          <svg viewBox="0 0 120 120" width="200" height="200">
            <circle cx="60" cy="60" r="52" fill="none" stroke="var(--line)" stroke-width="11"/>
            <circle id="scoreRing" cx="60" cy="60" r="52" fill="none" stroke="url(#g1)" stroke-width="11"
              stroke-linecap="round" stroke-dasharray="327" stroke-dashoffset="327" transform="rotate(-90 60 60)"/>
            <defs><linearGradient id="g1" x1="0" y1="0" x2="1" y2="1">
              <stop offset="0" stop-color="#ff5a3c"/><stop offset="1" stop-color="#ffb83c"/>
            </linearGradient></defs>
          </svg>
          <div class="ring-num">
            <div><b id="scoreVal">0</b><span>Strength Score</span></div>
          </div>
        </div>
        <div class="levelbadge" id="levelBadge">—</div>
        <p class="hint" id="levelHint" style="text-align:center"></p>
      </div>
      <div style="border-top:1px solid var(--line);margin-top:14px;padding-top:12px;display:flex;justify-content:space-between;font-size:12px">
        <div><span style="color:var(--mut)">Total (Big 3)</span><br><b id="big3" style="font-size:17px">— kg</b></div>
        <div style="text-align:right"><span style="color:var(--mut)">Wilks-style</span><br><b id="wilks" style="font-size:17px">—</b></div>
      </div>
    </div>
  </div>

  <!-- ===== SECTION: COMPARE VS LEGENDS ===== -->
  <div class="sectitle"><span class="bar"></span>Compare vs CrossFit Legends</div>
  <div class="card" style="margin-top:10px">
    <h2><span class="dot"></span>Benchmark Against the GOATs</h2>
    <div class="cmpbar">
      <div style="min-width:200px">
        <label>Select an athlete</label>
        <select id="athSel"></select>
      </div>
      <div class="athcard" id="athCard" style="display:none"></div>
      <div style="flex:1;min-width:160px">
        <span class="pill"><span class="leg-dot" style="background:var(--accent)"></span>You</span>
        <span class="pill" style="margin-left:6px"><span class="leg-dot" style="background:var(--blue)"></span>Legend</span>
        <p class="hint" style="margin-top:6px">Comparison is <b>bodyweight-relative</b> — each athlete scored against standards for their own bodyweight &amp; sex, so a 58 kg champion and a 90 kg athlete compare fairly.</p>
      </div>
    </div>
    <div class="vsgrid" id="vsGrid"></div>
  </div>

  <!-- ===== SECTION: PROFILE ANALYSIS ===== -->
  <div class="sectitle"><span class="bar"></span>Strength Profile Analysis</div>
  <div class="grid cols-2" style="margin-top:10px">
    <!-- RADAR -->
    <div class="card">
      <h2><span class="dot"></span>Relative Strength Radar</h2>
      <div class="radar-wrap"><svg id="radar" viewBox="0 0 360 320" width="100%" height="320"></svg></div>
      <p class="hint">Each axis = your lift as % of <b>Elite</b> standard for your bodyweight/sex. Outer ring = Elite.</p>
    </div>
    <!-- DIAGNOSTICS -->
    <div class="card">
      <h2><span class="dot"></span>Weakness Detection &amp; Coaching Feedback</h2>
      <div class="diag" id="diag"></div>
    </div>
  </div>

  <!-- ===== SECTION: ADVANCED RATIOS ===== -->
  <div class="sectitle"><span class="bar"></span>Advanced Differentiators</div>
  <div class="card" style="margin-top:10px">
    <h2><span class="dot"></span>Speed-Strength, Technical &amp; Pressing Efficiency</h2>
    <div class="ratios" id="ratioGrid" style="grid-template-columns:repeat(4,1fr)"></div>
  </div>

  <!-- ===== SECTION: READINESS ===== -->
  <div class="sectitle"><span class="bar"></span>CrossFit Readiness Score</div>
  <div class="grid cols-2" style="margin-top:10px">
    <div class="card">
      <h2><span class="dot"></span>Theoretical Hierarchy of Development</h2>
      <div class="wheels">
        <div class="wheel"><svg class="wsvg" data-w="strengthW" viewBox="0 0 90 90" width="100%"></svg><div class="sub">Strength</div></div>
        <div class="wheel"><svg class="wsvg" data-w="metaW" viewBox="0 0 90 90" width="100%"></svg><div class="sub">Metabolic</div></div>
        <div class="wheel"><svg class="wsvg" data-w="gymW" viewBox="0 0 90 90" width="100%"></svg><div class="sub">Gymnastics</div></div>
      </div>
      <div class="miniinputs">
        <div><label>2k Row (mm:ss)</label><input id="row2k" value="7:30"></div>
        <div><label>5k Run (mm:ss)</label><input id="run5k" value="24:00"></div>
        <div><label>Max Strict Pull-ups</label><input id="pullups" type="number" value="15"></div>
        <div><label>Max Ring MU</label><input id="mu" type="number" value="5"></div>
        <div><label>HS Walk (m)</label><input id="hswalk" type="number" value="10"></div>
        <div><label>L-sit hold (s)</label><input id="lsit" type="number" value="30"></div>
      </div>
      <p class="hint">Composite weighs strength, metabolic capacity (3 pathways) &amp; gymnastic body-control benchmarks.</p>
    </div>

    <!-- MRV MONITOR + power curve -->
    <div class="card">
      <h2><span class="dot"></span>MRV Recovery Monitor</h2>
      <div class="gauge-wrap">
        <svg id="mrvGauge" viewBox="0 0 240 140" width="280" height="160"></svg>
        <div class="mrv-status" id="mrvStatus">—</div>
        <div class="mrv-legend" id="mrvLegend"></div>
      </div>
      <div class="row2" style="margin-top:10px">
        <div><label>Weekly sets (hard)</label><input id="vol" type="number" value="80"></div>
        <div><label>Sleep / night (h)</label><input id="sleep" type="number" value="7" step="0.5"></div>
      </div>
      <div class="row2">
        <div><label>Resting HR (bpm)</label><input id="rhr" type="number" value="52"></div>
        <div><label>Soreness (1–10)</label><input id="sore" type="number" value="4" min="1" max="10"></div>
      </div>
      <p class="hint">Estimates <b>Max Recoverable Volume</b> headroom from volume vs. recovery markers. Red = recovery debt.</p>
    </div>
  </div>

  <!-- ===== SECTION: MACROCYCLE ===== -->
  <div class="sectitle"><span class="bar"></span>Macro-Cycle Programming</div>
  <div class="card" style="margin-top:10px">
    <h2><span class="dot"></span>9-Week Intensity Wave &amp; Daily Targets</h2>
    <div class="weekstrip" id="weekStrip"></div>
    <div style="display:flex;justify-content:space-between;align-items:center;margin-top:6px">
      <p class="hint">Select a week to compute target loads off your heavy single. Wave: build → peak → de-load.</p>
      <span class="pill" id="cycPhase">—</span>
    </div>
    <div class="targets" id="targets"></div>
  </div>

  <!-- ===== SECTION: PERCENT CALC ===== -->
  <div class="sectitle"><span class="bar"></span>Relative Intensity Scaler</div>
  <div class="card" style="margin-top:10px">
    <h2><span class="dot"></span>Percentage Loading Chart</h2>
    <div class="pctctl">
      <div style="flex:1"><label>Lift</label><select id="pctLift"></select></div>
      <div style="width:140px"><label>1RM (kg)</label><input id="pctMax" type="number" value="100"></div>
      <div style="width:160px"><label>Bar rounding</label>
        <select id="rounding"><option value="2.5">2.5 kg</option><option value="1">1 kg</option><option value="5">5 kg</option></select>
      </div>
    </div>
    <div class="pcttable" id="pctTable"></div>
    <p class="hint" style="margin-top:10px">Threshold zone (<span style="color:var(--accent2)">~80–90%</span>) highlighted — where technique degrades under intensity. Stay sharp on the "fine line of bad movement."</p>
  </div>

  <p class=
