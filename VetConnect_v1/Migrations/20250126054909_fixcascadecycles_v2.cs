using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace VetConnect_v1.Migrations
{
    /// <inheritdoc />
    public partial class fixcascadecycles_v2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<decimal>(
                name: "Peso",
                table: "Mascotas",
                type: "decimal(5,2)",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,2)");

            migrationBuilder.AlterColumn<decimal>(
                name: "Longitud",
                table: "Geolocalizaciones",
                type: "decimal(9,6)",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,2)");

            migrationBuilder.AlterColumn<decimal>(
                name: "Latitud",
                table: "Geolocalizaciones",
                type: "decimal(9,6)",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,2)");

            migrationBuilder.CreateIndex(
                name: "IX_TicketsSoporte_UsuarioId",
                table: "TicketsSoporte",
                column: "UsuarioId");

            migrationBuilder.CreateIndex(
                name: "IX_Servicios_MascotaId",
                table: "Servicios",
                column: "MascotaId");

            migrationBuilder.CreateIndex(
                name: "IX_Servicios_VeterinarioId",
                table: "Servicios",
                column: "VeterinarioId");

            migrationBuilder.CreateIndex(
                name: "IX_Mascotas_UsuarioId",
                table: "Mascotas",
                column: "UsuarioId");

            migrationBuilder.CreateIndex(
                name: "IX_Configuraciones_UsuarioId",
                table: "Configuraciones",
                column: "UsuarioId");

            migrationBuilder.CreateIndex(
                name: "IX_Citas_MascotaId",
                table: "Citas",
                column: "MascotaId");

            migrationBuilder.CreateIndex(
                name: "IX_Citas_UsuarioId",
                table: "Citas",
                column: "UsuarioId");

            migrationBuilder.CreateIndex(
                name: "IX_Citas_VeterinarioId",
                table: "Citas",
                column: "VeterinarioId");

            migrationBuilder.AddForeignKey(
                name: "FK_Citas_Mascotas_MascotaId",
                table: "Citas",
                column: "MascotaId",
                principalTable: "Mascotas",
                principalColumn: "MascotaId");

            migrationBuilder.AddForeignKey(
                name: "FK_Citas_Usuarios_UsuarioId",
                table: "Citas",
                column: "UsuarioId",
                principalTable: "Usuarios",
                principalColumn: "UsuarioId");

            migrationBuilder.AddForeignKey(
                name: "FK_Citas_Veterinarios_VeterinarioId",
                table: "Citas",
                column: "VeterinarioId",
                principalTable: "Veterinarios",
                principalColumn: "VeterinarioId");

            migrationBuilder.AddForeignKey(
                name: "FK_Configuraciones_Usuarios_UsuarioId",
                table: "Configuraciones",
                column: "UsuarioId",
                principalTable: "Usuarios",
                principalColumn: "UsuarioId");

            migrationBuilder.AddForeignKey(
                name: "FK_Mascotas_Usuarios_UsuarioId",
                table: "Mascotas",
                column: "UsuarioId",
                principalTable: "Usuarios",
                principalColumn: "UsuarioId");

            migrationBuilder.AddForeignKey(
                name: "FK_Servicios_Mascotas_MascotaId",
                table: "Servicios",
                column: "MascotaId",
                principalTable: "Mascotas",
                principalColumn: "MascotaId");

            migrationBuilder.AddForeignKey(
                name: "FK_Servicios_Veterinarios_VeterinarioId",
                table: "Servicios",
                column: "VeterinarioId",
                principalTable: "Veterinarios",
                principalColumn: "VeterinarioId");

            migrationBuilder.AddForeignKey(
                name: "FK_TicketsSoporte_Usuarios_UsuarioId",
                table: "TicketsSoporte",
                column: "UsuarioId",
                principalTable: "Usuarios",
                principalColumn: "UsuarioId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Citas_Mascotas_MascotaId",
                table: "Citas");

            migrationBuilder.DropForeignKey(
                name: "FK_Citas_Usuarios_UsuarioId",
                table: "Citas");

            migrationBuilder.DropForeignKey(
                name: "FK_Citas_Veterinarios_VeterinarioId",
                table: "Citas");

            migrationBuilder.DropForeignKey(
                name: "FK_Configuraciones_Usuarios_UsuarioId",
                table: "Configuraciones");

            migrationBuilder.DropForeignKey(
                name: "FK_Mascotas_Usuarios_UsuarioId",
                table: "Mascotas");

            migrationBuilder.DropForeignKey(
                name: "FK_Servicios_Mascotas_MascotaId",
                table: "Servicios");

            migrationBuilder.DropForeignKey(
                name: "FK_Servicios_Veterinarios_VeterinarioId",
                table: "Servicios");

            migrationBuilder.DropForeignKey(
                name: "FK_TicketsSoporte_Usuarios_UsuarioId",
                table: "TicketsSoporte");

            migrationBuilder.DropIndex(
                name: "IX_TicketsSoporte_UsuarioId",
                table: "TicketsSoporte");

            migrationBuilder.DropIndex(
                name: "IX_Servicios_MascotaId",
                table: "Servicios");

            migrationBuilder.DropIndex(
                name: "IX_Servicios_VeterinarioId",
                table: "Servicios");

            migrationBuilder.DropIndex(
                name: "IX_Mascotas_UsuarioId",
                table: "Mascotas");

            migrationBuilder.DropIndex(
                name: "IX_Configuraciones_UsuarioId",
                table: "Configuraciones");

            migrationBuilder.DropIndex(
                name: "IX_Citas_MascotaId",
                table: "Citas");

            migrationBuilder.DropIndex(
                name: "IX_Citas_UsuarioId",
                table: "Citas");

            migrationBuilder.DropIndex(
                name: "IX_Citas_VeterinarioId",
                table: "Citas");

            migrationBuilder.AlterColumn<decimal>(
                name: "Peso",
                table: "Mascotas",
                type: "decimal(18,2)",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(5,2)");

            migrationBuilder.AlterColumn<decimal>(
                name: "Longitud",
                table: "Geolocalizaciones",
                type: "decimal(18,2)",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(9,6)");

            migrationBuilder.AlterColumn<decimal>(
                name: "Latitud",
                table: "Geolocalizaciones",
                type: "decimal(18,2)",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(9,6)");
        }
    }
}
