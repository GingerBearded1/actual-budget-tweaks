# ABT 0.1.87 feature evaluation

Evaluated from the `custom` branch after Phase 3. This is a source review only: no ABT setting, Actual configuration, infrastructure, or budget data was changed.

## Support and implementation notes

- ABT exposes **49 user-facing settings** in its settings page.
- Every user-facing setting supports Actual's desktop component tree.
- Only **Theme** and **Privacy Style** declare mobile support. The runtime keeps every other setting's CSS and initialization out of Actual's mobile component tree below the 512 px breakpoint.
- **CSS** means styling only. **DOM/CSS** means selectors, markers, or observers plus styles. **Component** means ABT mounts Svelte UI. **API** means it reads Actual data or can invoke an Actual action. API writes occur only after an explicit user action.
- `DESKTOP ONLY` describes current ABT 0.1.87 support, not a judgment that the feature should never reach mobile.

The classifications are recommendations for the first evaluation pass:

- `KEEP CANDIDATE`: low-risk or clearly useful.
- `TEST`: evaluate visually and functionally before adopting.
- `PROBABLY SKIP`: limited value, visual noise, overlap, or potentially misleading output.
- `POSSIBLE BASE FOR CUSTOM WORK`: useful architecture or interaction to extend later.

## Theme

| Feature | What it changes | Desktop | Mobile | Implementation | Evaluation |
|---|---|---:|---:|---|---|
| Theme system | Built-in, community, and user-created palettes; token-level color editing; CSS import/export; one-theme or automatic light/dark selection. | Yes | Yes | Component + CSS variables + remote catalog | **KEEP CANDIDATE · MOBILE USEFUL · POSSIBLE BASE FOR CUSTOM WORK** — the strongest shared design foundation. Test one restrained light/dark pair first. |

The hidden Theme Loader reapplies saved per-theme overrides during startup. It is part of the theme foundation rather than a separate user-facing setting.

## Appearance

| Feature | What it changes | Desktop | Mobile | Implementation | Evaluation |
|---|---|---:|---:|---|---|
| Background Pattern | Adds a subtle app background pattern selected in a visual picker. | Yes | No | Component + CSS | **PROBABLY SKIP · DESKTOP ONLY** — decorative and may compete with financial information. |
| Themed Scrollbars | Makes scrollbars thin and theme-colored. | Yes | No | CSS | **KEEP CANDIDATE · DESKTOP ONLY** — low-risk polish. |
| Header Border | Adds a divider beneath Actual's top navigation. | Yes | No | CSS | **PROBABLY SKIP · DESKTOP ONLY** — minor if the modern titlebar or custom header already separates the page. |
| Privacy Style | Chooses scribble/dot treatments, including fixed-length versions, when Actual privacy mode is active. | Yes | Yes | CSS + privacy-mode bridge | **KEEP CANDIDATE · MOBILE USEFUL** — useful for screenshots and use around other people. |
| Modern Titlebar | Restyles top-bar actions with consistent icons and status chips. | Yes | No | DOM/CSS | **TEST · DESKTOP ONLY · POSSIBLE BASE FOR CUSTOM WORK** — promising desktop polish but sensitive to Actual's toolbar structure. |
| Modern Toasts | Renders notifications as compact cards with a colored accent. | Yes | No | CSS | **KEEP CANDIDATE · DESKTOP ONLY** — clearer feedback with little workflow risk. |
| Account Icon Picker | Stores an emoji, favicon, data URL, or URL for each account and displays it in the live sidebar. | Yes | No | DOM/CSS + component + stored metadata | **KEEP CANDIDATE · DESKTOP ONLY · POSSIBLE BASE FOR CUSTOM WORK** — helpful visual recognition; depends on Live sidebar. |
| Category Color Dots | Adds per-category colors and shows a dot beside transaction categories. | Yes | No | DOM/CSS + component + stored metadata | **TEST · DESKTOP ONLY** — useful scanning aid if the palette stays restrained. |
| Category Emoji Picker | Adds a custom emoji/icon per category. | Yes | No | DOM/CSS + component + stored metadata | **TEST · DESKTOP ONLY** — can improve recognition, but too many icons may add noise. |
| Dark Report Cards | Uses a darker background for report widgets. | Yes | No | CSS | **TEST · DESKTOP ONLY** — depends on the chosen theme and chart contrast. |
| Report Card Borders | Adds borders around report widgets. | Yes | No | CSS | **KEEP CANDIDATE · DESKTOP ONLY** — useful structure with low risk. |

## Layout

| Feature | What it changes | Desktop | Mobile | Implementation | Evaluation |
|---|---|---:|---:|---|---|
| Border Radius | Sets shared corner-radius tokens for cards and controls from a visual picker. | Yes | No | Component + CSS variables | **KEEP CANDIDATE · DESKTOP ONLY · POSSIBLE BASE FOR CUSTOM WORK** — central to a consistent design; mobile support is a good future extension. |
| Live Sidebar Layout | Chooses the standard replacement sidebar or a split icon-rail/accounts-panel layout. | Yes | No | Component option consumed by Live sidebar | **TEST · DESKTOP ONLY · POSSIBLE BASE FOR CUSTOM WORK** — compare both layouts after the base sidebar is stable. |
| Sidebar Density | Selects spacing for accounts, navigation, and search in the Live sidebar. | Yes | No | Component option + CSS variables | **KEEP CANDIDATE · DESKTOP ONLY** — directly useful for balancing clarity and information density. |
| Budget Table Row Height | Offers X-Slim, Slim, Normal, and Relaxed budget row spacing. | Yes | No | Component + CSS variables | **KEEP CANDIDATE · DESKTOP ONLY** — one of the best first tests; start with Normal or Relaxed. |
| Hide Month Selection On Scroll | Collapses the native month-navigation row as the budget table scrolls. | Yes | No | DOM/CSS + scroll logic | **TEST · DESKTOP ONLY** — useful on smaller desktop windows, but overlaps the experimental Month header. |
| Budget Page Borders | Adds structure around budget-table sections. | Yes | No | CSS | **TEST · DESKTOP ONLY** — test with the selected theme and row height to avoid a boxed-in look. |
| Resizable Transaction Columns | Adds draggable column edges and persists transaction-table widths. | Yes | No | DOM/CSS + pointer logic | **KEEP CANDIDATE · DESKTOP ONLY** — strong desktop productivity improvement. |
| Modern Reports Header | Keeps report title and dashboard controls visible while scrolling and restyles the title as a breadcrumb. | Yes | No | DOM/CSS | **KEEP CANDIDATE · DESKTOP ONLY** — useful for dashboards with several widgets. |

## Readability

| Feature | What it changes | Desktop | Mobile | Implementation | Evaluation |
|---|---|---:|---:|---|---|
| Color Negative Account Balances | Highlights negative sidebar balances in red. | Yes | No | DOM/CSS | **KEEP CANDIDATE · DESKTOP ONLY** — clear exception signaling; depends on Live sidebar. |
| Budget Card Styling | Replaces the current-month summary breakdown with a spending-flow bar using Actual budget cells. | Yes | No | DOM/CSS + component + read-only API | **TEST · DESKTOP ONLY · POSSIBLE BASE FOR CUSTOM WORK** — strong overview concept; compare against Month cards to avoid duplicate summaries. |
| Category Progress Indicators | Adds a progress ring beside each category balance and a hover popover with budgeted, spent, balance, shortfall, average spending, and days left. | Yes | No | DOM/CSS + component + read-only API | **TEST · DESKTOP ONLY · POSSIBLE BASE FOR CUSTOM WORK** — high value for funding decisions; hover interaction will need a different mobile pattern. |
| Balance Status Pills | Styles category balances as funded, underfunded, or overspent states. | Yes | No | DOM/CSS | **KEEP CANDIDATE · DESKTOP ONLY** — fast status recognition; test alongside progress indicators for visual overload. |
| Show Daily Available | Divides an account's positive balance by the days remaining in the month and displays a daily amount. | Yes | No | DOM logic | **PROBABLY SKIP · DESKTOP ONLY** — an account balance is not necessarily discretionary spendable money and may mislead. |
| Budget Totals Label Styling | Mutes and uppercases Budgeted, Spent, and Balance labels. | Yes | No | DOM/CSS | **KEEP CANDIDATE · DESKTOP ONLY** — small hierarchy improvement. |
| Alternating Transaction Row Colors | Zebra-stripes the transaction register. | Yes | No | CSS | **TEST · DESKTOP ONLY** — useful for scanning if the contrast is subtle. |
| Color Transactions | Colors inflows and outflows. | Yes | No | DOM/CSS | **PROBABLY SKIP · DESKTOP ONLY** — broad color use may compete with warnings and category states. |
| Dim Reconciled Transactions | Reduces emphasis on reconciled rows. | Yes | No | CSS | **KEEP CANDIDATE · DESKTOP ONLY** — directs attention to current work. |
| Highlight Uncategorized Transactions | Visually flags transactions without a category. | Yes | No | DOM/CSS | **KEEP CANDIDATE · DESKTOP ONLY · POSSIBLE BASE FOR CUSTOM WORK** — directly supports the planned review/agent workflow. |
| Quiet New Transactions | Replaces Actual's bold new-transaction treatment with a narrow accent bar. | Yes | No | DOM/CSS | **TEST · DESKTOP ONLY** — calmer register, but confirm new imports remain obvious. |
| Tag Styling | Colors `#tags` in notes and transaction fields. | Yes | No | DOM/CSS + stored tag colors | **PROBABLY SKIP · DESKTOP ONLY** until tags are part of the budgeting policy. |

## Workflows

| Feature | What it changes | Desktop | Mobile | Implementation | Evaluation |
|---|---|---:|---:|---|---|
| Live sidebar | Replaces Actual's sidebar with live balances, account groups, navigation, search, shortcuts, resize/collapse behavior, and status. | Yes | No | DOM/CSS + large component + read-only API | **TEST · DESKTOP ONLY · POSSIBLE BASE FOR CUSTOM WORK** — the main desktop shell candidate; test carefully because several features depend on it. |
| Sidebar Search Bar | Filters accounts, categories, and pages inside Live sidebar. | Yes | No | Live-sidebar component option | **KEEP CANDIDATE · DESKTOP ONLY** — high utility once Live sidebar is accepted. |
| Sidebar Shortcuts | Adds pinned links, tools, and widgets such as calculators, upcoming bills, stock tracking, and RSU tracking. Includes a nested “Show add tile” option. | Yes | No | Live-sidebar components + optional remote/API tools | **TEST · DESKTOP ONLY** — useful selectively; avoid turning the navigation into a widget tray. |
| Account Group Totals | Shows aggregate balances beside Live sidebar account groups. | Yes | No | Live-sidebar component option + read-only API | **KEEP CANDIDATE · DESKTOP ONLY** — useful at-a-glance context. |
| Budget Insights | Opens a side panel with month overview, template breakdown, priority planning, trends, and an explicit Apply Templates action. | Yes | No | DOM/CSS + component + Actual API; explicit write action | **TEST · DESKTOP ONLY · POSSIBLE BASE FOR CUSTOM WORK** — highly aligned with funding priorities and becoming one month ahead; validate calculations and write controls. |
| Next Month Coverage Method | Chooses recent average spending or goal templates as the coverage target used by Budget Insights. | Yes | No | Stored option + Budget Insights logic/API | **KEEP CANDIDATE · DESKTOP ONLY · POSSIBLE BASE FOR CUSTOM WORK** — directly supports the one-month-ahead goal. |
| Category Template Insights | Adds per-category bars showing template funding progress. | Yes | No | DOM/CSS + read-only API | **TEST · DESKTOP ONLY · POSSIBLE BASE FOR CUSTOM WORK** — strong funding signal; compare with progress rings and pills. |
| Quiet Funded Bars | Hides the fill for fully funded template bars so remaining needs stand out. | Yes | No | CSS; depends on Category Template Insights | **KEEP CANDIDATE · DESKTOP ONLY** — reduces noise if template bars are retained. |
| Goal Funding | Extends the category balance popover with goal progress and an explicit action to assign the shortfall. | Yes | No | DOM + component + Actual API; explicit write action | **TEST · DESKTOP ONLY · POSSIBLE BASE FOR CUSTOM WORK** — valuable, but first test against a non-production budget because it can budget funds. |
| Modern Account Toolbar | Reworks account actions, search, and buttons with consistent icons. | Yes | No | DOM/CSS | **KEEP CANDIDATE · DESKTOP ONLY · POSSIBLE BASE FOR CUSTOM WORK** — strong desktop polish and a host for Inspector/Reconcile. |
| Modern Reconcile | Replaces the reconcile popover/banner with a side panel showing live difference, transaction clearing, adjustment, finish, and undo. | Yes | No | DOM/CSS + component + Actual API; explicit write actions | **TEST · DESKTOP ONLY · POSSIBLE BASE FOR CUSTOM WORK** — potentially excellent, but requires a deliberate end-to-end test because it changes account state. |
| Sync recap | After bank sync/import, reports new items and opens a side panel where uncategorized transactions can be categorized. | Yes | No | Component + Actual API; explicit category writes | **KEEP CANDIDATE · DESKTOP ONLY · POSSIBLE BASE FOR CUSTOM WORK** — one of the strongest matches for the intended agent workflow. |
| Transaction Inspector | Adds an account-toolbar action that follows the selected transaction and shows payee history, matching rules, and schedule context. | Yes | No | DOM + component + read-only API | **TEST · DESKTOP ONLY · POSSIBLE BASE FOR CUSTOM WORK** — strong tool for categorization decisions and rule design. |
| Spending Calendar | Adds a Calendar destination with daily spending, month totals, and day details. | Yes | No | DOM + component + read-only API | **TEST · DESKTOP ONLY** — helpful behavioral view; confirm it earns permanent navigation space. |
| Month header (experimental) | Replaces native budget month controls with a full-width header, month picker, months-shown selector, and Today action. | Yes | No | DOM/CSS + component + API/navigation adapters | **TEST · DESKTOP ONLY · POSSIBLE BASE FOR CUSTOM WORK** — promising desktop header, but experimental and overlaps Hide Month Selection On Scroll. |
| Month cards (experimental) | Compacts multi-month cards; in single-month mode creates a full-width summary row with To Budget, spending, targets, and quick budget actions. | Yes | No | DOM/CSS + components + read/write action adapters | **TEST · DESKTOP ONLY · POSSIBLE BASE FOR CUSTOM WORK** — closest existing base for a polished budget dashboard; test separately from Budget Card Styling. |
| Category filter (experimental) | Filters budget rows to all, needs attention, overspent/short, or funded and handles keyboard navigation around hidden rows. | Yes | No | DOM/CSS + component + read-only API | **TEST · DESKTOP ONLY · POSSIBLE BASE FOR CUSTOM WORK** — highly useful for review sessions, but experimental table behavior needs testing. |

## Other existing foundations

These are active infrastructure features rather than ordinary settings:

| Foundation | Role | Support / evaluation |
|---|---|---|
| Budget view options | Adds a target toggle and Budget Settings dialog to the budget totals toolbar. | **Desktop only; KEEP CANDIDATE · POSSIBLE BASE FOR CUSTOM WORK.** It is the best existing home for budget-view controls. |
| Side panel | Shared host for Budget Insights, Sync recap, Reconcile, and Transaction Inspector. | **Desktop-oriented; POSSIBLE BASE FOR CUSTOM WORK.** Preserve as the common detailed-work surface. |
| Settings sync | Stores ABT preferences through Actual preferences so settings can follow the budget across clients. | **KEEP CANDIDATE · MOBILE USEFUL.** Important for consistent desktop/mobile presentation. |
| Native hooks and DOM watcher | Adds stable ABT markers around Actual UI and shares one observer across features. | **KEEP CANDIDATE · POSSIBLE BASE FOR CUSTOM WORK.** This is the safe extension layer for future UI. |
| Privacy-mode bridge | Reads Actual's privacy preference and exposes it as an ABT body state. | **Desktop and mobile foundation; KEEP CANDIDATE.** |
| Tooltip styling | Gives ABT/native tooltips a shared visual treatment. | **KEEP CANDIDATE.** Low-level polish. |
| Schedule highlighting | Supports links that open a specific schedule from a `highlight` query parameter. | **TEST.** Useful for cross-links from tools such as Transaction Inspector. |
| Release notification | Shows ABT release notes when an update is pending and allows opt-out. | **KEEP CANDIDATE.** Operational rather than product UI. |
| Live-sidebar notice | Defers sidebar-related notices when Actual is in mobile view because the desktop sidebar is absent. | **KEEP CANDIDATE.** Correctly respects Actual's separate mobile tree. |

## Recommended first test set

Test in small, reversible groups so overlapping features can be compared rather than enabled together indiscriminately.

1. **Shared design:** Theme system, Privacy Style, Border Radius, Modern Toasts.
2. **Budget readability:** Budget Table Row Height, Balance Status Pills, Category Progress Indicators, Category Template Insights, Quiet Funded Bars.
3. **Budget shell comparison:** test Budget Card Styling by itself, then Month header + Month cards by themselves. Keep only the clearer summary system.
4. **Review workflow:** Highlight Uncategorized, Dim Reconciled, Quiet New Transactions, Sync recap, Transaction Inspector.
5. **Desktop navigation:** Live sidebar, Sidebar Density, Sidebar Search, Account Group Totals, Account Icon Picker.
6. **Planning:** Budget Insights, Next Month Coverage Method, Category filter. Exercise Goal Funding and Modern Reconcile later on a test budget because they can write budget/account state.

For mobile, begin with the existing Theme and Privacy Style support. The best later candidates to adapt deliberately are Highlight Uncategorized, Sync recap, category progress/status, and a compact budget summary; their current desktop implementations cannot simply be switched on because Actual renders a different mobile component tree.
