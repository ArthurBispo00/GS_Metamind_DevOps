import { dirname } from "path";
import { fileURLToPath } from "url";
import { FlatCompat } from "@eslint/eslintrc";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const compat = new FlatCompat({
  baseDirectory: __dirname,
});

const eslintConfig = [
  ...compat.extends("next/core-web-vitals", "next/typescript"),

  // Adicione um novo objeto de configuração para desabilitar a regra
  {
    // Opcional: Especifique os arquivos para os quais esta regra se aplica,
    // se quiser desabilitar apenas em .tsx ou .ts, por exemplo.
    // files: ["**/*.ts", "**/*.tsx"],
    rules: {
      "@typescript-eslint/no-explicit-any": "off", // <--- A CORREÇÃO ESTÁ AQUI
      // Adicione outras regras que precise desabilitar aqui, se houver
    },
  },
];

export default eslintConfig;