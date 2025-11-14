## 🛠️ Lab Overview

**Purpose:** Design and build AI applications and agents using Azure AI Foundry—focusing on multilingual, multimodal scenarios, monitoring, and red teaming.

---

## 🚀 Exercise Breakdown

### Exercise 01 – Deploy & Configure Resources

- **Deploy Bicep script**
    - Creates a **Resource Group**
    - Provisions necessary Azure resources via Bicep
- **Configure Azure Resources**
    - Cosmos DB instance for product catalog
    - Azure AI Search index linked to Cosmos DB
    - Azure AI Foundry resource/project
- **Prepare Datasets**
    - CSV ingestion (e.g., `updated_product_catalog(in).csv`) to Cosmos DB via Python script
    - Populate Azure AI Search index

### Exercise 02 – Multimodal Shopping Assistant

- **Single-Agent POC**
    - Build a local chat app (Python, Uvicorn) using basic chat completion
- **Multi-Agent Solution**
    - Expand to multiple agents (e.g., chatbot, ordering) to handle image/video uploads
- **Deploy to Azure**
    - Build & push Docker image to Azure Container Registry (ACR)
    - Deploy container via Azure App Service

### Exercise 03 – A2A Protocol (Multi-Agent Communication)

- Implement **Agent-to-Agent (A2A)** using Semantic Kernel
- Add agents for marketing, ranking, and integrate plugins
- Enables inter-agent messaging and advanced flows

### Exercise 04 – Observability in Azure AI Foundry

- Instrument app using **OpenTelemetry SDK**
- Capture detailed trace data (requests/responses)
- View metrics and traces in Azure AI Foundry analytics

### Exercise 06 – AI-Enhanced Red Teaming

- Create a **Red Team Agent** using Azure AI Foundry & azure-ai-evaluation
- Run adversarial scans, establish security baselines
- Test against both PoC and deployed Azure OpenAI models


## 🔍 Azure Resources Deployed via Bicep (Exercise 01)

|Resource Type	| Description|
| :--- | :-- |
|Resource Group	|Primary container for lab resources|
|Cosmos DB	|NoSQL database for product catalog ingestion|
|Azure AI Search	|Search service with index loaded from Cosmos DB|
|Azure AI Foundry	|AI workspace/project for agents|
|Azure Container Registry	|Host for Docker images|
|Azure App Service	|Web hosting for chat container|


## 🔧 Summary of Lab Coverage
1. **Infrastructure Setup**
    - Bicep-driven deployment including RG, Cosmos DB, AI Search, AI Foundry, ACR, App Service
2. **Data Preparation**
    - Ingestion of local CSV into Cosmos DB
    - Search index populated from Cosmos DB content
3. **Application Development**
    - POC chat app (Python/Uvicorn) for multimodal interaction
    - Multi-agent architecture with messaging
4. **Cloud Deployment**
    - Dockerization and deployment via ACR & App Service
5. **Communications & Plugins**
    - A2A protocol for agent-to-agent interaction
    - Plugin extensibility for functional specialization
6. **Observability**
    - OpenTelemetry tracing in Azure Foundry
    - Metrics and diagnostics via Azure AI Foundry UI
7. **Security Testing**
    - Red Teaming workflows for vulnerability scanning
    - Baseline assessments & adversarial prompt testing