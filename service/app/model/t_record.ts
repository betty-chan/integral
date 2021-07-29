/* indent size: 2 */

module.exports = app => {
  const DataTypes = app.Sequelize;

  const Model = app.model.define('t_record', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true
    },
    goods_id: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    user_id: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    },
  }, {
    tableName: 't_record',
    timestamps: false,
  });

  Model.associate = function () {

  }

  return Model;
};
