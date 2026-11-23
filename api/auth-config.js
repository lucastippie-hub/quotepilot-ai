// Public Supabase project URL and publishable/anon key only. Never expose the service_role key.
export default function handler(req,res){res.setHeader('Cache-Control','no-store');res.status(200).json({url:process.env.SUPABASE_URL||'',anonKey:process.env.SUPABASE_ANON_KEY||''})}
