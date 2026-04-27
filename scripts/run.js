async function main() {
  const apiKey = process.env.RUNPOD_API_KEY;
  const url = "https://api.runpod.ai/v2/4fssso1rb7nubl/run";

  const requestConfig = {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      'Authorization': `Bearer ${apiKey}`,

    },
    body: JSON.stringify({"input":{"prompt":prompt}})
  };

  try {
    const response = await fetch(url, requestConfig);
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    const data = await response.json();
    console.log(data);
    return data;
  } catch (error) {
    console.error('Error:', error);
    throw error;
  }
}

// Get prompt from command line arguments
 const prompt = process.argv.slice(2).join(' ');
 main(prompt)
   .then(result => console.log('Success:', result))
   .catch(error => console.error('Error:', error));
