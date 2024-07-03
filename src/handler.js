import { main } from './index';

export const handler = async (event) => {
  console.debug(JSON.stringify(event));
  const result = await main(event);
  console.debug(result);
  return result;
};
