// 爱德思 IAL 学习系统 · Supabase 连接
// 与 CIE 系统共用同一个 Supabase 项目，但通过 prefix 使用一套完全独立的 edx_* 表和函数，
// 两套系统的数据、账号互不影响。anon key 是前端公开密钥（只能按 RLS 策略访问）。
window.PLAN_SYNC = {
  url: "https://pijljjeypqnbypjzfewn.supabase.co",
  key: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBpamxqamV5cHFuYnlwanpmZXduIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODg0NTA2NzcsImV4cCI6MjEwNDAyNjY3N30.aEeOZHWf3sad4Xa_juNjHGQ4LeXX55aCUMql7ENvYk8",
  table: "edx_progress",
  prefix: "edx_"
};
