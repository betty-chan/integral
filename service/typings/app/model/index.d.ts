// This file is created by egg-ts-helper@1.25.8
// Do not modify this file!!!!!!!!!

import 'egg';
import ExportTGoods from '../../../app/model/t_goods';
import ExportTGrade from '../../../app/model/t_grade';
import ExportTPower from '../../../app/model/t_power';
import ExportTRecord from '../../../app/model/t_record';
import ExportTSorce from '../../../app/model/t_sorce';
import ExportTUser from '../../../app/model/t_user';
import ExportTWish from '../../../app/model/t_wish';

declare module 'egg' {
  interface IModel {
    TGoods: ReturnType<typeof ExportTGoods>;
    TGrade: ReturnType<typeof ExportTGrade>;
    TPower: ReturnType<typeof ExportTPower>;
    TRecord: ReturnType<typeof ExportTRecord>;
    TSorce: ReturnType<typeof ExportTSorce>;
    TUser: ReturnType<typeof ExportTUser>;
    TWish: ReturnType<typeof ExportTWish>;
  }
}
