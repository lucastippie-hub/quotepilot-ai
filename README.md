# QuotePilot AI

A home-service estimating and sales pipeline prototype deployed to Vercel.

## Available features
- Responsive dashboard and quote builder
- Itemized estimates with tax, discounts and deposits
- Printable estimates and copyable follow-up messages
- Local quote history, pipeline, customer directory, CSV exports and JSON backup
- Server-side OpenAI drafting integration (disabled by default pending secure authentication and billing controls)

## Security and product readiness
**This is a prototype, not a production multi-tenant SaaS.** Browser localStorage is not secure cloud storage; do not enter sensitive customer data. Anyone using the same browser profile can see local records. There are no real user accounts, server-side customer records, paid subscriptions, or automated emails.

The AI endpoint `/api/generate` is **disabled by default**, even if `OPENAI_API_KEY` exists. It returns HTTP 503 until `QUOTEPILOT_AI_PUBLIC_ENABLED=true` is configured. **Do not set that flag on a public deployment**: the endpoint currently has no authenticated user identities, reliable distributed quota enforcement, or payment entitlement checks. The existing in-memory IP limiter is insufficient for protecting API spend.

## Next architecture steps
1. Create a Supabase project and configure authentication, Row Level Security and per-tenant access.
2. Move quotes and customers to protected database tables with server-validated authorization.
3. Implement durable per-user AI quotas, request-size limits, and verified Supabase access tokens before enabling AI.
4. Set up Stripe subscriptions and verified webhooks with idempotency and customer entitlements.
5. Add verified email delivery, custom domain, monitoring, privacy policy and terms reviewed for the business.

Never put `OPENAI_API_KEY`, Stripe secret keys, Supabase service-role keys or webhook secrets in browser JavaScript or this repository.

## Deployment
The static frontend is `index.html`. Vercel serves the Node function at `api/generate.js`. Commits to the default branch trigger Vercel deployments if GitHub integration is configured.
