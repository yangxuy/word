import { distributedKVStore } from "@kit.ArkData";
import { UIAbility } from "@kit.AbilityKit";
import { BusinessError } from "@kit.BasicServicesKit";

export class KvStoreManager {
  static readonly storeId: string = 'storeId'
  kvManager: distributedKVStore.KVManager | undefined = undefined
  kvStore: distributedKVStore.SingleKVStore | undefined = undefined;

  init(ability: UIAbility) {
    const kvManagerConfig: distributedKVStore.KVManagerConfig = {
      context: ability.context,
      bundleName: 'com.example.myapplication'
    };
    try {
      // 创建KVManager实例
      this.kvManager = distributedKVStore.createKVManager(kvManagerConfig);
      this.createOrGetKVStore()
    } catch (e) {
      console.error(`Failed to create KVManager. Code:`);
    }
  }

  createOrGetKVStore() {
    const options: distributedKVStore.Options = {
      createIfMissing: true,
      encrypt: false,
      backup: false,
      autoSync: false,
      kvStoreType: distributedKVStore.KVStoreType.SINGLE_VERSION,
      securityLevel: distributedKVStore.SecurityLevel.S3
    };
    this.kvManager?.getKVStore<distributedKVStore.SingleKVStore>(KvStoreManager.storeId, options,
      (err, store: distributedKVStore.SingleKVStore) => {
        if (err) {
          console.error(`Failed to get KVStore: Code:${err.code},message:${err.message}`);
          return;
        }
        console.info('Succeeded in getting KVStore.');
        this.kvStore = store;
      });
  }

  putData(key: string, value: Uint8Array | string | number | boolean) {
    try {
      this.kvStore?.put(key, value, (err) => {
        if (err !== undefined) {
          console.error(`Failed to put data. Code:${err.code},message:${err.message}`);
          return;
        }
        console.info('Succeeded in putting data.');
      });
    } catch (e) {
      let error = e as BusinessError;
      console.error(`An unexpected error occurred. Code:${error.code},message:${error.message}`);
    }
  }

  getData(key: string, callback: (data: boolean | string | number | Uint8Array) => void) {
    this.kvStore?.get(key, (err, data) => {
      if (err != undefined) {
        console.error(`Failed to get data. Code:${err.code},message:${err.message}`);
        return;
      }
      callback(data)
    });
  }
}

export const kvStore = new KvStoreManager()