---
name: evaluate-startup
description: Evaluates a startup idea (mobile app or SaaS) using a research-backed 10-category weighted checklist. Performs web research for each category and produces a 0-100 scored report with tier rating, risks, opportunities, and next steps. Trigger when the user says /evaluate-startup, "evaluate my startup idea", "score my startup", "analyze this startup idea", "how viable is my idea", or similar.
---

# Startup Idea Evaluator

Evaluate a startup idea (mobile app, SaaS, or both) using a structured research checklist. Perform live web research for each category, assign scores, and produce a comprehensive viability report.

## Inputs

Collect the following before starting. If not provided, ask the user:

| Input | Required | Description |
|-------|----------|-------------|
| `idea` | **Yes** | Full description of the startup idea |
| `user_base` | No | Who the target users are (infer from idea if omitted) |
| `platform` | No | `mobile`, `saas`, or `both` (default: evaluate both) |

Once you have the idea, confirm with the user: _"Got it — I'll now research and evaluate '[idea summary]' targeting [user base] as a [platform] product. This will take a few minutes."_

---

## Evaluation Checklist

Make a todo list with all 10 categories below, then work through them one by one. For each category: search the web, analyze findings, assign a score, and write a brief rationale.

### Category 1 — Problem Clarity & Pain Severity (15 points)

**Goal:** Confirm the problem is real, recurring, and painful enough that users actively seek solutions.

**Web searches to run:**
- `"[problem keywords] complaints users site:reddit.com"`
- `"[problem] how do people currently solve [pain point]"`
- `"[problem] frustrations workarounds"`

**Scoring guide:**
- 13–15: Problem is widely discussed, highly painful, no satisfying solution exists
- 10–12: Clear problem with moderate pain, some workarounds exist
- 7–9: Problem exists but pain is mild or niche
- 4–6: Problem is unclear or affects very few people
- 0–3: Manufactured problem or solution looking for a problem

---

### Category 2 — Market Size: TAM / SAM / SOM (15 points)

**Goal:** Estimate the total addressable market, serviceable addressable market, and obtainable market.

**Web searches to run:**
- `"[market segment] market size TAM 2024 2025 billion"`
- `"[industry] total addressable market report"`
- `"[target vertical] growth rate CAGR forecast"`
- `"number of [target users] worldwide"`

**Scoring guide:**
- 13–15: TAM > $1B, growing market, large reachable segment
- 10–12: TAM $100M–$1B, steady growth
- 7–9: TAM $10M–$100M, niche but viable
- 4–6: TAM < $10M or shrinking market
- 0–3: Market too small or undefined

---

### Category 3 — Competitive Landscape (10 points)

**Goal:** Assess existing competition, market saturation, and the startup's potential differentiation or moat.

**Web searches to run:**
- `"best [solution category] apps tools 2024 2025"`
- `"[idea keywords] alternatives competitors"`
- `"[idea] startup funding crunchbase site:crunchbase.com OR site:techcrunch.com"`
- Search the App Store / Play Store (describe what you'd find there) for similar apps

**Scoring guide:**
- 9–10: Clear white space or a meaningfully differentiated angle vs. fragmented incumbents
- 7–8: Competitors exist but clear differentiation is possible
- 5–6: Crowded market, differentiation possible but hard
- 3–4: Dominated by well-funded incumbents with high switching costs
- 0–2: Direct clone of existing product with no differentiation

---

### Category 4 — Business Model & Monetization (15 points)

**Goal:** Assess whether there is a credible, proven way to make money from this idea.

**Web searches to run:**
- `"[similar app or SaaS] pricing model revenue"`
- `"[vertical] SaaS pricing benchmarks"`
- `"[target user type] willingness to pay [solution type]"`
- `"[business model type] freemium conversion rate"`

**Scoring guide:**
- 13–15: Clear revenue model, validated pricing, strong willingness to pay signals
- 10–12: Revenue model viable, some pricing uncertainty
- 7–9: Monetization possible but requires significant experimentation
- 4–6: Revenue model unclear or relies on scale before monetization
- 0–3: No clear path to revenue

---

### Category 5 — Technical Feasibility (10 points)

**Goal:** Assess whether the product can be built with reasonable resources and within a reasonable timeline.

**Research approach:**
- Identify the core technical components required (AI/ML, real-time data, hardware integrations, APIs, etc.)
- Search: `"[core tech requirement] off the shelf API library"`
- Consider: data requirements, infrastructure costs, regulatory tech complexity

**Scoring guide:**
- 9–10: Buildable with existing tech stack, low integration complexity
- 7–8: Standard complexity, well-understood technical challenges
- 5–6: Non-trivial build, requires specialized expertise
- 3–4: Requires cutting-edge tech or major R&D investment
- 0–2: Technically infeasible with current technology

---

### Category 6 — Go-to-Market Strategy (10 points)

**Goal:** Assess the clarity and viability of customer acquisition channels.

**Web searches to run:**
- `"[target user] where do they hang out online communities"`
- `"[app category] user acquisition strategy"`
- `"[vertical] CAC customer acquisition cost benchmark"`
- `"[platform type] growth loop viral coefficient examples"`

**Scoring guide:**
- 9–10: Clear, low-cost acquisition channels; viral or product-led growth potential
- 7–8: Identifiable channels, reasonable CAC expectations
- 5–6: Channels exist but expensive or hard to scale
- 3–4: No clear acquisition strategy, relies on paid ads only
- 0–2: No identifiable path to first 1,000 users

---

### Category 7 — Unit Economics (10 points)

**Goal:** Estimate whether the business can achieve healthy LTV/CAC ratio and sustainable unit economics.

**Web searches to run:**
- `"[vertical] SaaS LTV CAC ratio benchmark"`
- `"[mobile app category] average revenue per user ARPU"`
- `"[business model] average churn rate"`
- `"[vertical] average contract value ACV"`

**Scoring guide (target: LTV ≥ 3× CAC, payback ≤ 18 months):**
- 9–10: Strong LTV/CAC ratio (>3x), short payback period (<12 months)
- 7–8: Reasonable ratio (2–3x), manageable payback (12–18 months)
- 5–6: Marginal economics, requires scale to work
- 3–4: Likely negative unit economics at launch
- 0–2: Fundamental unit economics problem

---

### Category 8 — Growth & Scalability (10 points)

**Goal:** Assess the startup's potential to scale beyond initial users — network effects, platform leverage, international potential.

**Web searches to run:**
- `"[product type] network effects examples"`
- `"[business model] scalability challenges"`
- `"[vertical] international expansion potential"`

**Scoring guide:**
- 9–10: Strong network effects, platform leverage, or international scalability
- 7–8: Scalable with investment, some platform advantages
- 5–6: Scales linearly, limited compounding advantages
- 3–4: Hard to scale; high marginal cost per user
- 0–2: Fundamentally local/non-scalable

---

### Category 9 — Regulatory & Legal (5 points)

**Goal:** Identify legal/regulatory risks that could delay or block the product.

**Web searches to run:**
- `"[industry] data privacy regulations GDPR CCPA requirements"`
- `"[sector] compliance requirements startups"`
- `"[product type] legal issues lawsuits"`

**Scoring guide:**
- 5: No significant regulatory hurdles, standard privacy requirements
- 4: Minor compliance requirements, manageable
- 3: Moderate regulatory exposure (healthcare, fintech, edtech)
- 2: Significant legal/regulatory complexity
- 0–1: High regulatory risk (financial services, medical devices, etc.) without a clear compliance path

---

### Category 10 — Platform-Specific Depth (qualitative, included in final commentary)

**Mobile-specific evaluation:**
- App Store / Play Store saturation: How many competing apps? Review quality?
- Retention mechanics: Does the app have clear reasons to return daily/weekly?
- Notification strategy: Push notifications as growth lever?
- DAU/MAU benchmark for the category (search: `"[app category] DAU MAU ratio benchmark"`)
- Monetization: IAP, subscriptions, ads — what's standard in this category?

**SaaS-specific evaluation:**
- Churn risk: What's typical churn for this vertical? (search: `"[vertical] SaaS churn rate benchmark"`)
- Expansion revenue: Can users upgrade, add seats, or expand usage over time?
- Pricing model fit: Seat-based, usage-based, flat fee — which fits the value delivery?
- Annual vs. monthly: What do competitors use? What does the buying process require?
- Sales motion: Self-serve vs. sales-assisted vs. enterprise — what does the deal size justify?

---

## Scoring & Report Generation

After completing all 9 scored categories:

1. Sum up all category scores for the total out of 100
2. Determine the tier:

| Score | Tier |
|-------|------|
| 85–100 | **Strong** — well-differentiated, clear market, high potential |
| 70–84 | **Good** — solid idea with addressable gaps |
| 55–69 | **Promising** — meaningful validation work needed |
| 40–54 | **High-Risk** — major concerns, consider pivots |
| 0–39 | **Challenging** — fundamental issues to resolve |

3. Generate the full report using the format below.

---

## Output Report Format

```
# Startup Idea Evaluation: [Idea Name / One-Line Summary]

**Platform:** [Mobile / SaaS / Both]
**Target Users:** [user base]
**Evaluated:** [current date]

---

## Executive Summary

[3–4 sentence overview covering the core idea, its strongest points, its biggest
risks, and the overall viability verdict.]

---

## Evaluation Scorecard

| # | Category                        | Score | Max | Quick Assessment              |
|---|---------------------------------|-------|-----|-------------------------------|
| 1 | Problem Clarity & Pain Severity |       | 15  |                               |
| 2 | Market Size (TAM/SAM/SOM)       |       | 15  |                               |
| 3 | Competitive Landscape           |       | 10  |                               |
| 4 | Business Model & Monetization   |       | 15  |                               |
| 5 | Technical Feasibility           |       | 10  |                               |
| 6 | Go-to-Market Strategy           |       | 10  |                               |
| 7 | Unit Economics                  |       | 10  |                               |
| 8 | Growth & Scalability            |       | 10  |                               |
| 9 | Regulatory & Legal              |        | 5   |                               |
|   | **TOTAL**                       | **XX**| **100** |                          |

### Overall Score: XX/100 — [TIER LABEL]

---

## Detailed Analysis

### 1. Problem Clarity & Pain Severity (X/15)
[Research findings, validation signals from web research, scoring rationale]

### 2. Market Size (X/15)
[TAM/SAM/SOM estimates with sources found during research]

### 3. Competitive Landscape (X/10)
[Key competitors found, differentiation assessment, moat potential]

### 4. Business Model & Monetization (X/15)
[Viable revenue models, comparable pricing, willingness-to-pay signals]

### 5. Technical Feasibility (X/10)
[Core tech components, complexity assessment, key technical risks]

### 6. Go-to-Market Strategy (X/10)
[Acquisition channels, estimated CAC, viral/PLG potential]

### 7. Unit Economics (X/10)
[LTV/CAC estimates, payback period, churn/retention benchmarks]

### 8. Growth & Scalability (X/10)
[Network effects, platform leverage, international potential]

### 9. Regulatory & Legal (X/5)
[Key regulations, compliance requirements, legal risks]

---

## Platform Analysis

### [Mobile / SaaS / Both] Considerations
[Findings from Category 10 platform-specific deep dive]

---

## Key Risks

1. **[Risk 1 — concise title]** — [1-2 sentence explanation]
2. **[Risk 2 — concise title]** — [1-2 sentence explanation]
3. **[Risk 3 — concise title]** — [1-2 sentence explanation]

---

## Key Opportunities

1. **[Opportunity 1]** — [1-2 sentence explanation]
2. **[Opportunity 2]** — [1-2 sentence explanation]
3. **[Opportunity 3]** — [1-2 sentence explanation]

---

## Recommended Next Steps

1. [Concrete validation action — e.g., "Run 10 user interviews with [user type] to validate willingness to pay"]
2. [Concrete build/test action — e.g., "Build a no-code landing page and run $500 in ads to test conversion"]
3. [Concrete research action — e.g., "Map all App Store competitors and identify the top 3 gaps in their reviews"]
```

---

## Wrap Up

In your final message to the user, include the full report above and add:

- A one-sentence **verdict** on whether to pursue, pivot, or pass
- An invitation: _"Would you like me to go deeper on any specific category, or explore a variation of this idea?"_
