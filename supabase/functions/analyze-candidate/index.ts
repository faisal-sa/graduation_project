import { serve } from "https://deno.land/std@0.168.0/http/server.ts"

const GEMINI_API_KEY = Deno.env.get('GEMINI_API_KEY');

serve(async (req) => {
  // 1. Handle CORS
  if (req.method === 'OPTIONS') {
    return new Response('ok', {
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
      },
    })
  }

  try {
    // 2. Parse Data (Matching your Flutter keys)
    const { candidateData, jobRequirements } = await req.json()
    
    // Convert to string for the prompt
    const candidateStr = JSON.stringify(candidateData);
    const jobStr = JSON.stringify(jobRequirements);

    // 3. Strict Prompt for JSON
    const prompt = `
      You are an expert HR Recruiter AI. 
      Analyze the candidate against the job requirements.
      
      CRITICAL INSTRUCTION: Output valid JSON only. Do not wrap in markdown. Do not add text.
      
      The JSON structure must be:
      {
        "score": (integer 0-100),
        "summary": "(string, brief analysis)",
        "pros": ["string", "string"],
        "cons": ["string", "string"]
      }

      Job Requirements: ${jobStr}
      Candidate Data: ${candidateStr}
    `;

    // 4. Call Google Gemini (Updated Model Name)
const url = `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=${GEMINI_API_KEY}`;    const aiResponse = await fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        contents: [{
          parts: [{ text: prompt }]
        }]
      }),
    })

    const data = await aiResponse.json()

    if (data.error) {
        throw new Error(data.error.message);
    }

    // 5. Clean and Return Data
    let content = data.candidates[0].content.parts[0].text;
    
    // Remove markdown code blocks if Gemini adds them
    content = content.replace(/```json|```/g, '').trim();

    return new Response(content, {
      headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' },
    })

  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' },
    })
  }
})