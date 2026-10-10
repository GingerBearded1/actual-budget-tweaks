import path from "node:path";
import { fileURLToPath } from "node:url";

const scriptDirectory = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(scriptDirectory, "..", "..");

process.env.HOST ||= "127.0.0.1";
process.env.PORT ||= "3005";
process.env.ACTUAL_ORIGIN ||= "http://127.0.0.1:5006";
process.env.ASSETS_DIR ||= path.join(repoRoot, ".output", "chrome-mv3");
process.env.PACKAGE_JSON_PATH ||= path.join(repoRoot, "package.json");

await import("../../docker/server.js");
